import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/core/network_utils/status.dart';
import 'package:valu_task/features/products/domain/entity/category.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';
import 'package:valu_task/features/products/domain/use_case/get_brands_by_category_use_case.dart';
import 'package:valu_task/features/products/domain/use_case/get_categories_use_case.dart';
import 'package:valu_task/features/products/domain/use_case/get_products_use_case.dart';
import 'package:valu_task/features/products/domain/use_case/update_product_order_quantitiy_use_case.dart';
import 'package:valu_task/features/products/domain/use_case/update_product_saved_use_case.dart';
import 'package:valu_task/features/products/domain/use_case/update_products_cart_use_case.dart';
import 'package:valu_task/features/products/presentation/home/home_events.dart';
import 'package:valu_task/features/products/presentation/home/home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvents, HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetBrandsByCategoryUseCase getBrandsByCategoryUseCase;
  final GetProductsUseCase getProductsUseCase;
  final UpdateProductsCartUseCase updateProductsCartUseCase;
  final UpdateProductSavedUseCase updateProductSavedUseCase;
  final UpdateProductOrderQuantityUseCase updateProductOrderQuantityUseCase;

  HomeBloc(this.getCategoriesUseCase,
      this.getBrandsByCategoryUseCase,
      this.getProductsUseCase,
      this.updateProductsCartUseCase,
      this.updateProductSavedUseCase,
      this.updateProductOrderQuantityUseCase,) : super(HomeState()) {
    on<GetCategoriesEvent>(_getCategories);
    on<ChangeSelectedCategoryEvent>(_changeSelectedCategory);
    on<GetBrandsEvent>(_getBrands);
    on<GetProductsEvent>(_getProducts);
    on<UpdateProductCartEvent>(_updateProductCart);
    on<UpdateProductSavedEvent>(_updateProductSaved);
    on<UpdateProductOrderQuantityEvent>(_updateProductOrderQuantity);
  }

  FutureOr<void> _getCategories(GetCategoriesEvent event,
      Emitter<HomeState> emit,) async {
    emit(
      state.copyWith(
        categories: const Results<List<Category>>.loading(),
        products: const Results<ProductsResponse>.loading(),
      ),
    );
    final response = await getCategoriesUseCase();
    if (response.status == Status.success &&
        response.data != null &&
        response.data!.isNotEmpty) {
      final firstCategory = response.data!.first;
      add(GetBrandsEvent(firstCategory.id));
      add(GetProductsEvent(category: firstCategory.id, page: 1));
    }
    emit(
      state.copyWith(
        categories: response,
        selectedCategory: response.data?.first,
      ),
    );
  }

  FutureOr<void> _changeSelectedCategory(ChangeSelectedCategoryEvent event,
      Emitter<HomeState> emit,) async {
    emit(
      state.copyWith(
        selectedCategory: event.category,
        products: const Results<ProductsResponse>.loading(),
      ),
    );
    add(GetBrandsEvent(event.category.id));
    add(GetProductsEvent(category: event.category.id, page: 1));
  }

  FutureOr<void> _getBrands(GetBrandsEvent event,
      Emitter<HomeState> emit,) async {
    emit(state.copyWith(brands: const Results<List<String>>.loading()));
    final response = await getBrandsByCategoryUseCase(category: event.category);
    emit(state.copyWith(brands: response));
  }

  FutureOr<void> _getProducts(GetProductsEvent event,
      Emitter<HomeState> emit,) async {
    emit(state.copyWith(products: const Results<ProductsResponse>.loading()));
    final response = await getProductsUseCase(
      category: event.category,
      page: event.page,
      pageSize: event.pageSize,
    );
    event.page++;
    emit(
      state.copyWith(
        products: response,
        currentPage: event.page,
        hasMorePages: event.page < 10,
      ),
    );
  }

  FutureOr<void> _updateProductCart(UpdateProductCartEvent event,
      Emitter<HomeState> emit,) async {
    final response = await updateProductsCartUseCase(
      event.productId,
      event.isInCart,
    );
    if (response.status == Status.success) {
      final currentProducts = state.products?.data?.products ?? [];
      final updatedProducts =
      currentProducts.map((product) {
        if (product.id == event.productId) {
          return product.copyWith(isInCart: event.isInCart);
        }
        return product;
      }).toList();
      emit(
        state.copyWith(
          products: Results.success(
            data:
            state.products?.data?.copyWith(products: updatedProducts) ??
                ProductsResponse(products: updatedProducts),
          ),
        ),
      );
    }
  }

  FutureOr<void> _updateProductSaved(UpdateProductSavedEvent event,
      Emitter<HomeState> emit,) async {
    final response = await updateProductSavedUseCase(
      event.productId,
      event.isSaved,
    );
    if (response.status == Status.success) {
      final currentProducts = state.products?.data?.products ?? [];
      final updatedProducts =
      currentProducts.map((product) {
        if (product.id == event.productId) {
          return product.copyWith(isSaved: event.isSaved);
        }
        return product;
      }).toList();
      emit(
        state.copyWith(
          products: Results.success(
            data:
            state.products?.data?.copyWith(products: updatedProducts) ??
                ProductsResponse(products: updatedProducts),
          ),
        ),
      );
    }
  }

  FutureOr<void> _updateProductOrderQuantity(
      UpdateProductOrderQuantityEvent event,
      Emitter<HomeState> emit,) async {
    final response = await updateProductOrderQuantityUseCase(
      event.productId,
      event.quantity,
    );
    if (response.status == Status.success) {
      final currentProducts = state.products?.data?.products ?? [];
      final updatedProducts =
      currentProducts.map((product) {
        if (product.id == event.productId) {
          return product.copyWith(orderQuantity: event.quantity);
        }
        return product;
      }).toList();
      emit(
        state.copyWith(
          products: Results.success(
            data:
            state.products?.data?.copyWith(products: updatedProducts) ??
                ProductsResponse(products: updatedProducts),
          ),
        ),
      );
    }
  }
}
