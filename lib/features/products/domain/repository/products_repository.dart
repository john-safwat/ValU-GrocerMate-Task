import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';

abstract interface class ProductsRepository {
  Future<Results<ProductsResponse>> getProductsByCategory({
    required String category,
    required int page,
    required int pageSize,
  });

  Future<Results<void>> updateProductCart(
    String productId,
    bool isInCart,
  );

  Future<Results<void>> updateProductSaved(String productId, bool isSaved);

  Future<Results<void>> updateProductOrderQuantity(
    String productId,
    int quantity,
  );

  Future<Results<Product>> getProductById(String productId);

  Future<Results<List<Product>>> searchProducts(String query);
  Future<Results<List<Product>>> getSavedProducts();
  Future<Results<void>> addAllNonCartSavedToCart();
}
