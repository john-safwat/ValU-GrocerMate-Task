import 'package:valu_task/features/products/data/models/local_product.dart';
import 'package:valu_task/features/products/data/models/local_product_details.dart';

abstract interface class ProductsLocalDatasource {
  Future<List<LocalProduct>> getProductsByCategory({required String category});

  Future<LocalProduct?> getProductById(String productId);

  Future<LocalProductDetails?> getProductDetailsById(String productId);
  Future<void> saveProductDetails(LocalProductDetails productDetails);

  Future<void> saveProducts(List<LocalProduct> products);

  Future<void> updateCart(String productId, bool isFavorite);

  Future<void> updateSaved(String productId, bool isSaved);

  Future<void> updateOrderQuantity(String productId, int quantity);

  Future<List<LocalProduct>> searchProducts(String query);
}
