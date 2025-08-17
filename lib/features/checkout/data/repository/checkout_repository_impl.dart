import 'package:injectable/injectable.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/core/network_utils/safe_api_call.dart';
import 'package:valu_task/features/checkout/data/datasource/contract/checkout_local_datasource.dart';
import 'package:valu_task/features/checkout/data/datasource/contract/checkout_remote_datasource.dart';
import 'package:valu_task/features/checkout/data/mapper/purchase_response_mapper.dart';
import 'package:valu_task/features/checkout/domain/entity/purchase_response.dart';
import 'package:valu_task/features/checkout/domain/repository/checkout_repository.dart';
import 'package:valu_task/features/products/data/mappers/products_mapper.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';

@Injectable(as: CheckoutRepository)
class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDatasource checkoutRemoteDatasource;
  final CheckoutLocalDatasource checkoutLocalDatasource;
  final ProductsMapper productsMapper;
  final PurchaseResponseMapper purchaseResponseMapper;

  CheckoutRepositoryImpl(
    this.checkoutRemoteDatasource,
    this.checkoutLocalDatasource,
    this.productsMapper,
    this.purchaseResponseMapper,
  );

  @override
  Future<Results<List<Product>>> getCartProducts() async {
    return safeApiCall<List<Product>>(() async {
      var localProducts = await checkoutLocalDatasource.getProducts();
      if (localProducts.isEmpty) {
        return const Results.success(data: []);
      }
      var changeInStock = await checkoutRemoteDatasource.getChangeInStock([]);
      List<Product> products = [];
      for (var localProduct in localProducts) {
        var product = productsMapper.mapLocalProductToProduct(localProduct);

        var changeInPrice = await checkoutRemoteDatasource.getChangeInPrice(
          product.id,
        );
        if (changeInPrice.productId == product.id) {
          product.updatePrice = (changeInPrice.history?.last ?? 0).toDouble();
        }
        for (var change in changeInStock.stocks ?? []) {
          if (change.productId == product.id) {
            product.stock = change.stock;
          }
        }
        products.add(product);
      }
      return Results.success(data: products);
    });
  }

  @override
  Future<Results<PurchaseResponseEntity>> checkout(
    List<Product> products,
    String currency,
  ) async {
    return safeApiCall(() async {
      var response = await checkoutRemoteDatasource.checkout(
        products,
        currency,
      );
      await checkoutLocalDatasource.clearCart();
      return Results.success(data: purchaseResponseMapper.fromDto(response));
    });
  }
}
