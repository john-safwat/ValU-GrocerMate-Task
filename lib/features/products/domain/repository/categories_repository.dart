import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/products/domain/entity/category.dart';

abstract interface class CategoriesRepository {
  Future<Results<List<Category>>> getCategories();

  Future<Results<List<String>>> getBrandsList({required String category});
}
