import 'package:injectable/injectable.dart';
import 'package:valu_task/features/checkout/data/models/purchase_response_dto.dart';
import 'package:valu_task/features/checkout/domain/entity/purchase_response.dart';

@injectable
class PurchaseResponseMapper {
  PurchaseResponseEntity fromDto(PurchaseResponseDto dto) {
    return PurchaseResponseEntity(
      status: dto.status,
      orderId: dto.orderId ?? '',
      finalTotal: dto.finalTotal ?? 0.0,
      changes: dto.changes?.map(mapPriceChange).toList() ?? [],
      fulfilled: dto.fulfilled?.map(mapFulfilledItem).toList() ?? [],
      missing: dto.missing?.map(mapMissingItem).toList() ?? [],
      note: dto.note ?? '',
      items: dto.items?.map(mapOutOfStockItem).toList() ?? [],
      priceChanges: dto.priceChanges?.map(mapPriceChange).toList() ?? [],
      oos: dto.oos?.map(mapOutOfStockItem).toList() ?? [],
    );
  }

  PriceChangeEntity mapPriceChange(PriceChange dto) {
    return PriceChangeEntity(
      productId: dto.productId,
      oldPrice: dto.oldPrice,
      newPrice: dto.newPrice,
    );
  }

  FulfilledItemEntity mapFulfilledItem(FulfilledItem dto) {
    return FulfilledItemEntity(productId: dto.productId, qty: dto.qty);
  }

  MissingItemEntity mapMissingItem(MissingItem dto) {
    return MissingItemEntity(productId: dto.productId, qty: dto.qty);
  }

  OutOfStockItemEntity mapOutOfStockItem(OutOfStockItem dto) {
    return OutOfStockItemEntity(
      productId: dto.productId,
      available: dto.available,
    );
  }
}
