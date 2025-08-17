import 'package:valu_task/features/checkout/domain/entity/purchase_response_status.dart';

class PurchaseResponseEntity {
  final PurchaseResponseStatus status;
  final String orderId;
  final double finalTotal;
  final List<PriceChangeEntity> changes;
  final List<FulfilledItemEntity> fulfilled;
  final List<MissingItemEntity> missing;
  final String note;
  final List<OutOfStockItemEntity> items;
  final List<PriceChangeEntity> priceChanges;
  final List<OutOfStockItemEntity> oos;

  PurchaseResponseEntity({
    required this.status,
    required this.orderId,
    required this.finalTotal,
    required this.changes,
    required this.fulfilled,
    required this.missing,
    required this.note,
    required this.items,
    required this.priceChanges,
    required this.oos,
  });
}

// Entity for price change objects.
class PriceChangeEntity {
  final String productId;
  final double oldPrice;
  final double newPrice;

  PriceChangeEntity({
    required this.productId,
    required this.oldPrice,
    required this.newPrice,
  });
}

// Entity for fulfilled item objects.
class FulfilledItemEntity {
  final String productId;
  final int qty;

  FulfilledItemEntity({required this.productId, required this.qty});
}

// Entity for missing item objects.
class MissingItemEntity {
  final String productId;
  final int qty;

  MissingItemEntity({required this.productId, required this.qty});
}

// Entity for out-of-stock item objects.
class OutOfStockItemEntity {
  final String productId;
  final int available;

  OutOfStockItemEntity({required this.productId, required this.available});
}
