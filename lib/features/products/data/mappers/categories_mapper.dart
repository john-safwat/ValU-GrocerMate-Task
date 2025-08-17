import 'package:injectable/injectable.dart';
import 'package:valu_task/features/products/data/models/category_dto.dart';
import 'package:valu_task/features/products/data/models/local_category.dart';
import 'package:valu_task/features/products/domain/entity/category.dart';

@injectable
class CategoriesMapper {
  List<Category> mapCategoryDtoListToCategoryList(
    List<CategoryDto> categories,
  ) {
    return categories.map((e) => mapCategoryDtoToCategory(e)).toList();
  }

  List<Category> mapLocalCategoryListToCategoryList(
    List<LocalCategory> categories,
  ) {
    return categories.map((e) => mapLocalCategoryToCategory(e)).toList();
  }

  List<LocalCategory> mapCategoriesDtoToLocalCategories(
    List<CategoryDto> categories,
  ) {
    return categories.map((e) => mapCategoryDtoToLocalCategory(e)).toList();
  }

  Category mapCategoryDtoToCategory(CategoryDto category) {
    return Category(
      id: category.id ?? "",
      name: "${category.icon} ${category.name}",
    );
  }

  Category mapLocalCategoryToCategory(LocalCategory category) {
    return Category(
      id: category.categoryId ?? "",
      name: "${category.icon} ${category.name}",
    );
  }

  LocalCategory mapCategoryDtoToLocalCategory(CategoryDto category) {
    return LocalCategory(
      categoryId: category.id,
      name: category.name,
      icon: category.icon,
    );
  }
}
