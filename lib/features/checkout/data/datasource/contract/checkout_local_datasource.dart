import 'package:valu_task/features/products/data/models/local_product.dart';

abstract interface class CheckoutLocalDatasource {
  Future<List<LocalProduct>> getProducts();

  Future<void> clearCart();
}
