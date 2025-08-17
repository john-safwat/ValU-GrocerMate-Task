import 'package:injectable/injectable.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';
import 'package:valu_task/features/products/domain/repository/products_repository.dart';

@injectable
class GetProductDetailsUseCase {
  final ProductsRepository repository;

  GetProductDetailsUseCase(this.repository);

  Future<Results<Product>> call(String productId) async {
    return await repository.getProductById(productId);
  }
}