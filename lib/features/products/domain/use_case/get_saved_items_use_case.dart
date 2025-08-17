import 'package:injectable/injectable.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';
import 'package:valu_task/features/products/domain/repository/products_repository.dart';

@injectable
class GetSavedProductsUseCase {
  final ProductsRepository repository;

  GetSavedProductsUseCase(this.repository);

  Future<Results<List<Product>>> call() async {
    return await repository.getSavedProducts();
  }
}
