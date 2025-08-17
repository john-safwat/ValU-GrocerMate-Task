import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';

class SearchState {
  final Results<List<Product>> products;

  SearchState({
    this.products = const Results<List<Product>>.initial(),
  });

  SearchState copyWith({
    Results<List<Product>>? products,
  }) {
    return SearchState(
      products: products ?? this.products,
    );
  }
}