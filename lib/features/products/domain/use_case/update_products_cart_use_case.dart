import 'package:injectable/injectable.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/products/domain/repository/products_repository.dart';

@injectable
class UpdateProductsCartUseCase {
  ProductsRepository repository;

  UpdateProductsCartUseCase(this.repository);

  Future<Results<void>> call(String productId, bool isInCart) {
    return repository.updateProductCart(productId, isInCart);
  }
}
