import 'package:injectable/injectable.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/products/domain/repository/products_repository.dart';

@injectable
class UpdateProductOrderQuantityUseCase {
  ProductsRepository repository;

  UpdateProductOrderQuantityUseCase(this.repository);

  Future<Results<void>> call(String productId, int quantity) {
    return repository.updateProductOrderQuantity(productId, quantity);
  }
}
