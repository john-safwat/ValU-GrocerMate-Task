import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:valu_task/features/products/data/datasource/contract/categories_local_datasource.dart';
import 'package:valu_task/features/products/data/models/local_category.dart';

@Injectable(as: CategoriesLocalDatasource)
class CategoriesLocalDatasourceImpl implements CategoriesLocalDatasource {
  Isar isar;

  CategoriesLocalDatasourceImpl(this.isar);

  @override
  Future<List<LocalCategory>> getCategoriesList() async {
    var categories = await await isar.writeTxn(() async {
      final localCategories = isar.collection<LocalCategory>();
      var categories = await localCategories.where().findAll();
      return categories;
    });
    return categories;
  }

  @override
  Future<void> saveCategoriesList(List<LocalCategory> categories) async {
    await isar.writeTxn(() async {
      final localCategories = isar.collection<LocalCategory>();
      await localCategories.clear();
      await localCategories.putAll(categories);
    });
  }
}
