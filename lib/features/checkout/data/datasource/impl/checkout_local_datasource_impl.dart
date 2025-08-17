import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:valu_task/features/checkout/data/datasource/contract/checkout_local_datasource.dart';
import 'package:valu_task/features/products/data/models/local_product.dart';

@Injectable(as: CheckoutLocalDatasource)
class CheckoutLocalDatasourceImpl implements CheckoutLocalDatasource {
  final Isar isar;

  CheckoutLocalDatasourceImpl(this.isar);

  @override
  Future<List<LocalProduct>> getProducts() async {
    return isar.localProducts.filter().isInCartEqualTo(true).findAll();
  }

  @override
  Future<void> clearCart() async {
    await isar.writeTxn(() async {
      var products =
          await isar.localProducts.filter().isInCartEqualTo(true).findAll();
      for (var product in products) {
        product.isInCart = false;
        await isar.localProducts.put(product);
      }
    });
  }
}