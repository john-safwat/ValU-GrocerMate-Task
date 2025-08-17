import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:valu_task/features/products/data/datasource/contract/categories_remote_datasource.dart';
import 'package:valu_task/features/products/data/models/category_dto.dart';

@Injectable(as: CategoriesRemoteDatasource)
class CategoriesRemoteDatasourceImpl implements CategoriesRemoteDatasource {
  AssetBundle assetBundle;

  CategoriesRemoteDatasourceImpl(this.assetBundle);

  @override
  Future<List<CategoryDto>> getCategoriesList() async {
    var response = await assetBundle.loadString("assets/files/categories.json");
    var jsonValue = json.decode(response);
    List<CategoryDto> categories = [];
    for (var element in jsonValue) {
      categories.add(CategoryDto.fromJson(element));
    }
    return categories;
  }

  @override
  Future<List<String>> getBrandByCategory({required String category}) async {
    var response = await assetBundle.loadString("assets/files/brand_by_category.json");
    final jsonValue = json.decode(response) as Map<String, dynamic>;
    final List<dynamic> brandsList = jsonValue[category] ?? [];
    return List<String>.from(brandsList);
  }
}
