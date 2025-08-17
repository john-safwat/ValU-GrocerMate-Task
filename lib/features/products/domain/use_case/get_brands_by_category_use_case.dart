import 'package:injectable/injectable.dart';
import 'package:valu_task/features/products/domain/repository/categories_repository.dart';

import '../../../../core/network_utils/results.dart';

@injectable
class GetBrandsByCategoryUseCase {
  CategoriesRepository repository;

  GetBrandsByCategoryUseCase(this.repository);

  Future<Results<List<String>>> call({required String category}) async {
    return await repository.getBrandsList(category: category);
  }
}
