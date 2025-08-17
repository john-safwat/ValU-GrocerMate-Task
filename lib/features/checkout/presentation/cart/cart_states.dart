import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/checkout/domain/entity/purchase_response.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';

class CartState {
  final Results<List<Product>> products;
  final Results<PurchaseResponseEntity> purchase;
  final double subtotal;
  final double discount;
  final double tax;

  final double total;

  CartState({
    this.products = const Results<List<Product>>.initial(),
    this.purchase = const Results<PurchaseResponseEntity>.initial(),
    this.subtotal = 0.0,
    this.discount = 0.0,
    this.tax = 0.0,
    this.total = 0.0,
  });

  CartState copyWith({
    Results<List<Product>>? products,
    Results<PurchaseResponseEntity>? purchase,
    double? subtotal,
    double? discount,
    double? tax,
    double? total,
  }) {
    return CartState(
      products: products ?? this.products,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      purchase: purchase ?? this.purchase,
    );
  }
}
