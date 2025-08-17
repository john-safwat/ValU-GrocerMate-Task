import 'package:injectable/injectable.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';
import 'package:valu_task/features/products/domain/repository/products_repository.dart';

@injectable
class GetProductsUseCase {
  ProductsRepository repository;

  GetProductsUseCase(this.repository);

  Future<Results<ProductsResponse>> call({
    required String category,
    required int page,
    required int pageSize,
  }) {
    return repository.getProductsByCategory(
      category: category,
      page: page,
      pageSize: pageSize,
    );
  }
}