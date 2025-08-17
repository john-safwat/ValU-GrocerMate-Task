import 'package:injectable/injectable.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/products/domain/repository/products_repository.dart';

@injectable
class AddAllNonCartSavedToCartUseCase {
  final ProductsRepository repository;

  AddAllNonCartSavedToCartUseCase(this.repository);

  Future<Results> call() async {
    return await repository.addAllNonCartSavedToCart();
  }
}
