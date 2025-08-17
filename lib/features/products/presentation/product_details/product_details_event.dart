sealed class ProductDetailsEvent {
  const ProductDetailsEvent();
}

class FetchProductDetails extends ProductDetailsEvent {
  final String productId;

  const FetchProductDetails(this.productId);
}

class UpdateProductCart extends ProductDetailsEvent {
  final String productId;
  final bool isInCart;

  const UpdateProductCart(this.productId, this.isInCart);
}

class UpdateProductSaved extends ProductDetailsEvent {
  final String productId;
  final bool isSaved;

  const UpdateProductSaved(this.productId, this.isSaved);
}

class UpdateProductOrderQuantity extends ProductDetailsEvent {
  final String productId;
  final int quantity;

  const UpdateProductOrderQuantity(this.productId, this.quantity);
}
