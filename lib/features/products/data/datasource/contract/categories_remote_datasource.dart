import 'package:valu_task/features/products/data/models/category_dto.dart';

abstract interface class CategoriesRemoteDatasource {
  Future<List<CategoryDto>> getCategoriesList();

  Future<List<String>> getBrandByCategory({required String category});
}
