import 'package:injectable/injectable.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/checkout/domain/repository/checkout_repository.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';

@injectable
class GetCartProductsUseCase {
  final CheckoutRepository repository;

  GetCartProductsUseCase(this.repository);

  Future<Results<List<Product>>> call() async {
    return repository.getCartProducts();
  }
}
