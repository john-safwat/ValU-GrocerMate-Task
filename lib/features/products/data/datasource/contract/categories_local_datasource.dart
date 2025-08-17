import 'package:valu_task/features/products/data/models/local_category.dart';

abstract interface class CategoriesLocalDatasource {
  Future<List<LocalCategory>> getCategoriesList();

  Future<void> saveCategoriesList(List<LocalCategory> categories);
}
