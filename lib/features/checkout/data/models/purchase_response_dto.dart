import 'dart:convert';

import 'package:valu_task/features/checkout/domain/entity/purchase_response_status.dart';

class PurchaseResponseDto {
  final PurchaseResponseStatus status;
  final String? orderId;
  final double? finalTotal;
  final List<PriceChange>? changes;
  final List<FulfilledItem>? fulfilled;
  final List<MissingItem>? missing;
  final String? note;
  final List<OutOfStockItem>? items;
  final List<PriceChange>? priceChanges;
  final List<OutOfStockItem>? oos;

  PurchaseResponseDto({
    required this.status,
    this.orderId,
    this.finalTotal,
    this.changes,
    this.fulfilled,
    this.missing,
    this.note,
    this.items,
    this.priceChanges,
    this.oos,
  });

  // Helper function to convert a string to an ApiResponseStatus enum value.
  static PurchaseResponseStatus _statusFromString(String? status) {
    switch (status) {
      case 'success':
        return PurchaseResponseStatus.success;
      case 'price_changed':
        return PurchaseResponseStatus.priceChanged;
      case 'partial':
        return PurchaseResponseStatus.partial;
      case 'out_of_stock':
        return PurchaseResponseStatus.outOfStock;
      case 'review_required':
        return PurchaseResponseStatus.reviewRequired;
      default:
        return PurchaseResponseStatus.success;
    }
  }

  // Factory constructor to create an ApiResponse instance from a JSON map.
  // It now parses the status string into the ApiResponseStatus enum.
  factory PurchaseResponseDto.fromJson(Map<String, dynamic> json) {
    return PurchaseResponseDto(
      status: _statusFromString(json['status']),
      orderId: json['orderId'],
      finalTotal: (json['finalTotal'] as num?)?.toDouble(),
      changes:
          json['changes'] != null
              ? (json['changes'] as List)
                  .map((item) => PriceChange.fromJson(item))
                  .toList()
              : null,
      fulfilled:
          json['fulfilled'] != null
              ? (json['fulfilled'] as List)
                  .map((item) => FulfilledItem.fromJson(item))
                  .toList()
              : null,
      missing:
          json['missing'] != null
              ? (json['missing'] as List)
                  .map((item) => MissingItem.fromJson(item))
                  .toList()
              : null,
      note: json['note'],
      items:
          json['items'] != null
              ? (json['items'] as List)
                  .map((item) => OutOfStockItem.fromJson(item))
                  .toList()
              : null,
      priceChanges:
          json['priceChanges'] != null
              ? (json['priceChanges'] as List)
                  .map((item) => PriceChange.fromJson(item))
                  .toList()
              : null,
      oos:
          json['oos'] != null
              ? (json['oos'] as List)
                  .map((item) => OutOfStockItem.fromJson(item))
                  .toList()
              : null,
    );
  }

  // A helper method to convert the object to a string for easy printing.
  @override
  String toString() {
    final Map<String, dynamic> data = {
      // Convert enum to string for printing
      'status': status.name,
      'orderId': orderId,
      'finalTotal': finalTotal,
      'changes': changes?.map((e) => e.toString()).toList(),
      'fulfilled': fulfilled?.map((e) => e.toString()).toList(),
      'missing': missing?.map((e) => e.toString()).toList(),
      'note': note,
      'items': items?.map((e) => e.toString()).toList(),
      'priceChanges': priceChanges?.map((e) => e.toString()).toList(),
      'oos': oos?.map((e) => e.toString()).toList(),
    };
    // Remove null values for cleaner output
    data.removeWhere((key, value) => value == null);
    return 'ApiResponse: ${jsonEncode(data)}';
  }
}

// Model for price change objects.
class PriceChange {
  final String productId;
  final double oldPrice;
  final double newPrice;

  PriceChange({
    required this.productId,
    required this.oldPrice,
    required this.newPrice,
  });

  factory PriceChange.fromJson(Map<String, dynamic> json) {
    return PriceChange(
      productId: json['productId'],
      oldPrice: (json['oldPrice'] as num).toDouble(),
      newPrice: (json['newPrice'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'PriceChange{productId: $productId, oldPrice: $oldPrice, newPrice: $newPrice}';
  }
}

// Model for fulfilled item objects.
class FulfilledItem {
  final String productId;
  final int qty;

  FulfilledItem({required this.productId, required this.qty});

  factory FulfilledItem.fromJson(Map<String, dynamic> json) {
    return FulfilledItem(productId: json['productId'], qty: json['qty']);
  }

  @override
  String toString() {
    return 'FulfilledItem{productId: $productId, qty: $qty}';
  }
}

// Model for missing item objects.
class MissingItem {
  final String productId;
  final int qty;

  MissingItem({required this.productId, required this.qty});

  factory MissingItem.fromJson(Map<String, dynamic> json) {
    return MissingItem(productId: json['productId'], qty: json['qty']);
  }

  @override
  String toString() {
    return 'MissingItem{productId: $productId, qty: $qty}';
  }
}

// Model for out-of-stock item objects.
class OutOfStockItem {
  final String productId;
  final int available;

  OutOfStockItem({required this.productId, required this.available});

  factory OutOfStockItem.fromJson(Map<String, dynamic> json) {
    return OutOfStockItem(
      productId: json['productId'],
      available: json['available'],
    );
  }

  @override
  String toString() {
    return 'OutOfStockItem{productId: $productId, available: $available}';
  }
}
