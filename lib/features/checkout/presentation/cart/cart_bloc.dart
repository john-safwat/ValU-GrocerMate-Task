import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:valu_task/core/di/di.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/core/network_utils/status.dart';
import 'package:valu_task/core/provider/app_config_provider.dart';
import 'package:valu_task/features/checkout/domain/use_case/chekout_use_case.dart';
import 'package:valu_task/features/checkout/domain/use_case/get_cart_products_use_case.dart';
import 'package:valu_task/features/checkout/presentation/cart/cart_events.dart';
import 'package:valu_task/features/checkout/presentation/cart/cart_states.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';
import 'package:valu_task/features/products/domain/use_case/update_product_order_quantitiy_use_case.dart';
import 'package:valu_task/features/products/domain/use_case/update_product_saved_use_case.dart';
import 'package:valu_task/features/products/domain/use_case/update_products_cart_use_case.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartProductsUseCase getCartProductsUseCase;
  final UpdateProductOrderQuantityUseCase updateProductOrderQuantityUseCase;
  final UpdateProductsCartUseCase updateProductsCartUseCase;
  final UpdateProductSavedUseCase updateProductSavedUseCase;
  final CheckoutUseCase checkoutUseCase;
  double taxRate = getIt<AppConfigProvider>().appConfiguration.taxRate ?? 0;
  double deliveryFee =
      getIt<AppConfigProvider>().appConfiguration.deliveryFee ?? 0;
  double freeDeliveryThreshold =
      getIt<AppConfigProvider>().appConfiguration.freeDeliveryThreshold ?? 0;

  CartBloc(
    this.getCartProductsUseCase,
    this.updateProductOrderQuantityUseCase,
    this.updateProductsCartUseCase,
    this.updateProductSavedUseCase,
    this.checkoutUseCase,
  ) : super(CartState()) {
    on<FetchCartProducts>(_onFetchCartProducts);
    on<UpdateCartProductQuantity>(_onUpdateCartProductQuantity);
    on<RemoveProductFromCart>(_onRemoveProductFromCart);
    on<CheckoutEvent>(_checkout);
    on<SaveAllForLater>(_onSaveAllForLater);
  }

  CartState _calculateFinancials(List<Product>? products) {
    if (products == null || products.isEmpty) {
      return state.copyWith(subtotal: 0.0, discount: 0.0, tax: 0.0, total: 0.0);
    }

    final subtotal = products.fold<double>(
      0,
      (sum, product) =>
          sum + (product.updatePrice ?? product.price) * product.orderQuantity,
    );

    final discount = products.fold<double>(0, (sum, product) {
      final currentPrice = product.updatePrice ?? product.price;
      final originalPrice = product.originalPrice;
      if (originalPrice > currentPrice) {
        return sum + (originalPrice - currentPrice) * product.orderQuantity;
      }
      return sum;
    });

    final tax = subtotal * taxRate;
    final delivery = subtotal >= freeDeliveryThreshold ? 0.0 : deliveryFee;
    final total = subtotal - discount + tax + delivery;

    return state.copyWith(
      subtotal: subtotal,
      discount: discount,
      tax: tax,
      total: total,
    );
  }

  Future<void> _onFetchCartProducts(
    FetchCartProducts event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(products: const Results.loading()));
    final result = await getCartProductsUseCase();
    emit(_calculateFinancials(result.data).copyWith(products: result));
  }

  Future<void> _onUpdateCartProductQuantity(
    UpdateCartProductQuantity event,
    Emitter<CartState> emit,
  ) async {
    final result = await updateProductOrderQuantityUseCase(
      event.productId,
      event.quantity,
    );
    if (result.status == Status.success) {
      final currentProducts = state.products.data;
      if (currentProducts != null) {
        final updatedProducts =
            currentProducts.map((product) {
              if (product.id == event.productId) {
                return product.copyWith(orderQuantity: event.quantity);
              }
              return product;
            }).toList();
        emit(
          _calculateFinancials(
            updatedProducts,
          ).copyWith(products: Results.success(data: updatedProducts)),
        );
      }
    }
  }

  Future<void> _onRemoveProductFromCart(
    RemoveProductFromCart event,
    Emitter<CartState> emit,
  ) async {
    final result = await updateProductsCartUseCase(event.productId, false);
    if (result.status == Status.success) {
      final currentProducts = state.products.data;
      if (currentProducts != null) {
        final updatedProducts =
            currentProducts
                .where((product) => product.id != event.productId)
                .toList();
        emit(
          _calculateFinancials(
            updatedProducts,
          ).copyWith(products: Results.success(data: updatedProducts)),
        );
      }
    }
  }

  Future<void> _onSaveAllForLater(
    SaveAllForLater event,
    Emitter<CartState> emit,
  ) async {
    final currentProducts = state.products.data;
    if (currentProducts != null && currentProducts.isNotEmpty) {
      bool allSuccess = true;
      for (final product in currentProducts) {
        final savedResult = await updateProductSavedUseCase(product.id, true);
        final cartResult = await updateProductsCartUseCase(product.id, false);
        if (savedResult.status != Status.success ||
            cartResult.status != Status.success) {
          allSuccess = false;
          break;
        }
      }
      if (allSuccess) {
        emit(
          _calculateFinancials(
            [],
          ).copyWith(products: const Results.success(data: [])),
        );
      }
    }
  }

  FutureOr<void> _checkout(CheckoutEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(purchase: const Results.loading()));
    final result = await checkoutUseCase(
      state.products.data ?? [],
      getIt<AppConfigProvider>().appConfiguration.currency ?? "USD",
    );
    emit(
      state.copyWith(
        products:
            result.status == Status.success ? const Results.success(data: []) : null,
        purchase: result,
      ),
    );
  }
}
