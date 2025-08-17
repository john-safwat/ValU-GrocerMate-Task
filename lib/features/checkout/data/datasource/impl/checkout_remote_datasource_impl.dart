import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:valu_task/features/checkout/data/datasource/contract/checkout_remote_datasource.dart';
import 'package:valu_task/features/checkout/data/models/change_in_price_dto.dart';
import 'package:valu_task/features/checkout/data/models/change_in_stock_dto.dart';
import 'package:valu_task/features/checkout/data/models/purchase_response_dto.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';

@Injectable(as: CheckoutRemoteDatasource)
class CheckoutRemoteDatasourceImpl implements CheckoutRemoteDatasource {
  final AssetBundle assetBundle;

  CheckoutRemoteDatasourceImpl(this.assetBundle);

  @override
  Future<ChangeInPriceDto> getChangeInPrice(String productId) async {
    final data = await assetBundle.loadString(
      'assets/files/price_history_milk_2pct.json',
    );
    return ChangeInPriceDto.fromJson(json.decode(data));
  }

  @override
  Future<ChangeInStockDto> getChangeInStock(List<String> productIds) async {
    final data = await assetBundle.loadString('assets/files/stock_check.json');
    return ChangeInStockDto.fromJson(json.decode(data));
  }

  @override
  Future<PurchaseResponseDto> checkout(
    List<Product> products,
    String currency,
  ) async {
    final data = await assetBundle.loadString(
      'assets/files/purchase_success.json',
    );
    return PurchaseResponseDto.fromJson(json.decode(data));
  }
}
