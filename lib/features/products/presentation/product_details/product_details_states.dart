import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';

class ProductDetailsState {
  final Results<Product> product;

  ProductDetailsState({this.product = const Results<Product>.initial()});

  ProductDetailsState copyWith({Results<Product>? product}) {
    return ProductDetailsState(product: product ?? this.product);
  }
}
