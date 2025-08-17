import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/checkout/domain/entity/purchase_response.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';

abstract interface class CheckoutRepository {
  Future<Results<List<Product>>> getCartProducts();

  Future<Results<PurchaseResponseEntity>> checkout(
    List<Product> products,
    String currency,
  );
}
