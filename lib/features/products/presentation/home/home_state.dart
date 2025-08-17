import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/features/products/domain/entity/category.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';

class HomeState {
  Results<List<Category>>? categories = const Results<List<Category>>.initial();
  Results<List<String>>? brands = const Results<List<String>>.initial();
  Results<ProductsResponse>? products =
      const Results<ProductsResponse>.initial();
  Results<List<Product>>? savedItems = const Results<List<Product>>.initial();
  Category? selectedCategory;
  int currentPage = 1;
  bool hasMorePages = true;

  HomeState({
    this.categories,
    this.brands,
    this.products,
    this.selectedCategory,
    this.currentPage = 1,
    this.savedItems,
    this.hasMorePages = true,
  });

  HomeState copyWith({
    Results<List<Category>>? categories,
    Results<List<String>>? brands,
    Results<ProductsResponse>? products,
    Category? selectedCategory,
    int? currentPage,
    bool? hasMorePages,
    Results<List<Product>>? savedItems,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      brands: brands ?? this.brands,
      products: products ?? this.products,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      currentPage: currentPage ?? this.currentPage,
      hasMorePages: hasMorePages ?? this.hasMorePages,
      savedItems: savedItems ?? this.savedItems,
    );
  }
}
