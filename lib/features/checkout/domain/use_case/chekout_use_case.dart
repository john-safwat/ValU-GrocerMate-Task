import 'package:injectable/injectable.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/checkout/domain/entity/purchase_response.dart';
import 'package:valu_task/features/checkout/domain/repository/checkout_repository.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';

@injectable
class CheckoutUseCase {
  CheckoutRepository repository;

  CheckoutUseCase(this.repository);

  Future<Results<PurchaseResponseEntity>> call(
    List<Product> products,
    String currency,
  ) async {
    return await repository.checkout(products, currency);
  }
}
