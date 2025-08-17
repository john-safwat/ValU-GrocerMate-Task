import 'package:injectable/injectable.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';
import 'package:valu_task/features/products/domain/repository/products_repository.dart';

@injectable
class SearchProductsUseCase {
  final ProductsRepository repository;

  SearchProductsUseCase(this.repository);

  Future<Results<List<Product>>> call(String query) async {
    return await repository.searchProducts(query);
  }
}
