import 'package:valu_task/features/checkout/data/models/change_in_price_dto.dart';
import 'package:valu_task/features/checkout/data/models/change_in_stock_dto.dart';
import 'package:valu_task/features/checkout/data/models/purchase_response_dto.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';

abstract interface class CheckoutRemoteDatasource {
  Future<ChangeInPriceDto> getChangeInPrice(String productId);

  Future<ChangeInStockDto> getChangeInStock(List<String> productIds);
  Future<PurchaseResponseDto> checkout(List<Product> products , String currency);

}
