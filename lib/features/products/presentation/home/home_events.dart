import 'package:valu_task/features/products/domain/entity/category.dart';

sealed class HomeEvents {}

class GetCategoriesEvent extends HomeEvents {}

class ChangeSelectedCategoryEvent extends HomeEvents {
  Category category;

  ChangeSelectedCategoryEvent(this.category);
}

class GetBrandsEvent extends HomeEvents {
  String category;

  GetBrandsEvent(this.category);
}

class GetProductsEvent extends HomeEvents {
  String category;
  int page;
  int pageSize;

  GetProductsEvent({
    required this.category,
    required this.page,
    this.pageSize = 10, // Default page size
  });
}

class UpdateProductCartEvent extends HomeEvents {
  String productId;
  bool isInCart;

  UpdateProductCartEvent(this.productId, this.isInCart);
}

class UpdateProductSavedEvent extends HomeEvents {
  String productId;
  bool isSaved;

  UpdateProductSavedEvent(this.productId, this.isSaved);
}

class UpdateProductOrderQuantityEvent extends HomeEvents {
  String productId;
  int quantity;

  UpdateProductOrderQuantityEvent(this.productId, this.quantity);
}
