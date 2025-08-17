import 'package:injectable/injectable.dart';
import 'package:valu_task/features/products/domain/entity/category.dart';
import 'package:valu_task/features/products/domain/repository/categories_repository.dart';

import '../../../../core/network_utils/results.dart';

@injectable
class GetCategoriesUseCase {
  CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Results<List<Category>>> call() {
    return repository.getCategories();
  }
}
