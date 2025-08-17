import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/core/network_utils/status.dart';
import 'package:valu_task/features/products/domain/use_case/get_product_details_use_case.dart';
import 'package:valu_task/features/products/domain/use_case/update_product_order_quantitiy_use_case.dart';
import 'package:valu_task/features/products/domain/use_case/update_product_saved_use_case.dart';
import 'package:valu_task/features/products/domain/use_case/update_products_cart_use_case.dart';
import 'package:valu_task/features/products/presentation/product_details/product_details_event.dart';
import 'package:valu_task/features/products/presentation/product_details/product_details_states.dart';

@injectable
class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;
  final UpdateProductsCartUseCase updateProductsCartUseCase;
  final UpdateProductSavedUseCase updateProductSavedUseCase;
  final UpdateProductOrderQuantityUseCase updateProductOrderQuantityUseCase;

  ProductDetailsBloc(
    this.getProductDetailsUseCase,
    this.updateProductOrderQuantityUseCase,
    this.updateProductSavedUseCase,
    this.updateProductsCartUseCase,
  ) : super(ProductDetailsState()) {
    on<FetchProductDetails>(_onFetchProductDetails);
    on<UpdateProductCart>(_onUpdateProductCart);
    on<UpdateProductSaved>(_onUpdateProductSaved);
    on<UpdateProductOrderQuantity>(_onUpdateProductOrderQuantity);
  }

  Future<void> _onFetchProductDetails(
    FetchProductDetails event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(state.copyWith(product: const Results.loading()));
    final result = await getProductDetailsUseCase(event.productId);
    emit(state.copyWith(product: result));
  }

  Future<void> _onUpdateProductCart(
    UpdateProductCart event,
    Emitter<ProductDetailsState> emit,
  ) async {
    final result = await updateProductsCartUseCase(
      event.productId,
      event.isInCart,
    );
    if(event.isInCart){
      state.product.data?.orderQuantity = 1;
    }
    if (result.status == Status.success) {
      final currentProduct = state.product.data;
      if (currentProduct != null) {
        emit(
          state.copyWith(
            product: Results.success(
              data: currentProduct.copyWith(isInCart: event.isInCart),
            ),
          ),
        );
      }
    } else {
      // Optionally emit an error state or show a snackbar in the UI
    }
  }

  Future<void> _onUpdateProductSaved(
    UpdateProductSaved event,
    Emitter<ProductDetailsState> emit,
  ) async {
    final result = await updateProductSavedUseCase(
      event.productId,
      event.isSaved,
    );
    if (result.status == Status.success) {
      final currentProduct = state.product.data;
      if (currentProduct != null) {
        emit(
          state.copyWith(
            product: Results.success(
              data: currentProduct.copyWith(isSaved: event.isSaved),
            ),
          ),
        );
      }
    } else {
      // Optionally emit an error state or show a snackbar in the UI
    }
  }

  Future<void> _onUpdateProductOrderQuantity(
    UpdateProductOrderQuantity event,
    Emitter<ProductDetailsState> emit,
  ) async {
    if (event.quantity <= 0) {
      add(UpdateProductCart(event.productId, false));
    }
    final result = await updateProductOrderQuantityUseCase(
      event.productId,
      event.quantity,
    );
    if (result.status == Status.success) {
      final currentProduct = state.product.data;
      if (currentProduct != null) {
        emit(
          state.copyWith(
            product: Results.success(
              data: currentProduct.copyWith(orderQuantity: event.quantity),
            ),
          ),
        );
      }
    } else {
      // Optionally emit an error state or show a snackbar in the UI
    }
  }
}
