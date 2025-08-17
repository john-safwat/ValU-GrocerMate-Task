import 'package:injectable/injectable.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/products/domain/repository/products_repository.dart';

@injectable
class UpdateProductSavedUseCase {
  ProductsRepository repository;

  UpdateProductSavedUseCase(this.repository);

  Future<Results<void>> call(String productId, bool isSaved) {
    return repository.updateProductSaved(productId, isSaved);
  }
}
