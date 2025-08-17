import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:valu_task/features/products/data/datasource/contract/products_remote_datasource.dart';
import 'package:valu_task/features/products/data/models/deals_of_the_day_dto.dart';
import 'package:valu_task/features/products/data/models/product_details_dto.dart';
import 'package:valu_task/features/products/data/models/products_response_dto.dart';

@Injectable(as: ProductsRemoteDatasource)
class ProductsRemoteDatasourceImpl implements ProductsRemoteDatasource {
  AssetBundle assetBundle;

  ProductsRemoteDatasourceImpl(this.assetBundle);

  @override
  Future<ProductsResponseDto> getProductsByCategory({
    required String category,
    required int page,
    required int pageSize,
  }) async {
    String response = "";
    try {
      response = await assetBundle.loadString(
        "assets/files/products_$category.json",
      );
    } catch (e) {
      response = "{}";
    }
    var jsonValue = json.decode(response);
    return ProductsResponseDto.fromJson(jsonValue);
  }

  @override
  Future<ProductDetailsDto> getProductDetailsById(String productId) async {
    try {
      final response = await assetBundle.loadString(
        "assets/files/$productId.json",
      );
      return ProductDetailsDto.fromJson(json.decode(response));
    } catch (e) {
      throw Exception('Failed to load product details for ID $productId');
    }
  }

  @override
  Future<DealsOfTheDayDto> getDealsOfTheDay() async {
    var response = await assetBundle.loadString(
      "assets/files/deals_of_day.json",
    );
    return DealsOfTheDayDto.fromJson(json.decode(response));
  }
}
