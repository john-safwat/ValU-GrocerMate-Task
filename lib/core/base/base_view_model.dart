import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valu_task/features/products/domain/use_case/update_product_order_quantitiy_use_case.dart';
import 'package:valu_task/features/products/domain/use_case/update_product_saved_use_case.dart';
import 'package:valu_task/features/products/domain/use_case/update_products_cart_use_case.dart';

abstract class BaseViewModel<S, E> extends Bloc<S, E> {
  final UpdateProductsCartUseCase updateProductsCartUseCase;
  final UpdateProductSavedUseCase updateProductSavedUseCase;
  final UpdateProductOrderQuantityUseCase updateProductOrderQuantityUseCase;

  BaseViewModel(
    this.updateProductsCartUseCase,
    this.updateProductSavedUseCase,
    this.updateProductOrderQuantityUseCase,
    super.initialState,
  );
}
