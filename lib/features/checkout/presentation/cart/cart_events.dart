sealed class CartEvent {
  const CartEvent();
}

class FetchCartProducts extends CartEvent {
  const FetchCartProducts();
}

class UpdateCartProductQuantity extends CartEvent {
  final String productId;
  final int quantity;

  const UpdateCartProductQuantity(this.productId, this.quantity);
}

class RemoveProductFromCart extends CartEvent {
  final String productId;

  const RemoveProductFromCart(this.productId);
}

class SaveAllForLater extends CartEvent {
  const SaveAllForLater();
}

class CheckoutEvent extends CartEvent {
  const CheckoutEvent();
}

