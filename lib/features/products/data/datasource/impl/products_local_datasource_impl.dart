import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:valu_task/features/products/data/datasource/contract/products_local_datasource.dart';
import 'package:valu_task/features/products/data/models/local_product.dart';
import 'package:valu_task/features/products/data/models/local_product_details.dart';

@Injectable(as: ProductsLocalDatasource)
class ProductsLocalDatasourceImpl implements ProductsLocalDatasource {
  Isar isar;

  ProductsLocalDatasourceImpl(this.isar);

  @override
  Future<List<LocalProduct>> getProductsByCategory({
    required String category,
  }) async {
    return isar.localProducts.filter().categoryIdEqualTo(category).findAll();
  }

  @override
  Future<LocalProductDetails?> getProductDetailsById(String productId) async {
    return isar.localProductDetails
        .filter()
        .productIdEqualTo(productId)
        .findFirst();
  }

  @override
  Future<void> saveProductDetails(LocalProductDetails productDetails) async {
    await isar.writeTxn(() async {
      final existing =
          await isar.localProductDetails
              .filter()
              .productIdEqualTo(productDetails.productId)
              .findFirst();
      if (existing != null) {
        existing.title = productDetails.title;
        existing.brand = productDetails.brand;
        existing.price = productDetails.price;
        existing.originalPrice = productDetails.originalPrice;
        existing.stock = productDetails.stock;
        existing.images = productDetails.images;
        existing.description = productDetails.description;
        existing.nutrition = productDetails.nutrition;
        existing.allergens = productDetails.allergens;
        existing.related = productDetails.related;
        existing.isInCart = productDetails.isInCart;
        existing.isInSaved = productDetails.isInSaved;
        existing.orderQuantity = productDetails.orderQuantity;
        await isar.localProductDetails.put(existing);
      } else {
        await isar.localProductDetails.put(productDetails);
      }
    });
  }

  @override
  Future<LocalProduct?> getProductById(String productId) async {
    return isar.localProducts.filter().idEqualTo(productId).findFirst();
  }

  @override
  Future<void> saveProducts(List<LocalProduct> products) async {
    await isar.writeTxn(() async {
      for (var p in products) {
        var existing =
            await isar.localProducts.filter().idEqualTo(p.id).findFirst();
        if (existing != null) {
          existing.title = p.title;
          existing.brand = p.brand;
          existing.price = p.price;
          existing.originalPrice = p.originalPrice;
          existing.stock = p.stock;
          existing.image = p.image;
          existing.badges = p.badges;
          existing.categoryId = p.categoryId;
          existing.rating = p.rating;
          await isar.localProducts.put(existing);
        } else {
          await isar.localProducts.put(p);
        }
      }
    });
  }

  @override
  Future<void> updateCart(String productId, bool isInCart) async {
    await isar.writeTxn(() async {
      var product =
          await isar.localProducts.filter().idEqualTo(productId).findFirst();
      if (product != null) {
        product.isInCart = isInCart;
        await isar.localProducts.put(product);
      }
    });
  }

  @override
  Future<void> updateSaved(String productId, bool isSaved) async {
    await isar.writeTxn(() async {
      var product =
          await isar.localProducts.filter().idEqualTo(productId).findFirst();
      if (product != null) {
        product.isInSaved = isSaved;
        await isar.localProducts.put(product);
      }
    });
  }

  @override
  Future<void> updateOrderQuantity(String productId, int quantity) async {
    await isar.writeTxn(() async {
      var product =
          await isar.localProducts.filter().idEqualTo(productId).findFirst();
      if (product != null) {
        product.orderQuantity = quantity;
        await isar.localProducts.put(product);
      }
    });
  }
}
