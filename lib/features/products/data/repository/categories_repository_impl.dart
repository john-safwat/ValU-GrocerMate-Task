import 'package:injectable/injectable.dart';
import 'package:valu_task/core/base_ui/app_error_message.dart';
import 'package:valu_task/core/network_utils/app_errors.dart';
import 'package:valu_task/core/network_utils/network_info.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/core/network_utils/safe_api_call.dart';
import 'package:valu_task/features/products/data/datasource/contract/categories_local_datasource.dart';
import 'package:valu_task/features/products/data/datasource/contract/categories_remote_datasource.dart';
import 'package:valu_task/features/products/data/mappers/categories_mapper.dart';
import 'package:valu_task/features/products/domain/entity/category.dart';
import 'package:valu_task/features/products/domain/repository/categories_repository.dart';

@Injectable(as: CategoriesRepository)
class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDatasource remoteDatasource;
  final CategoriesLocalDatasource localDatasource;
  final NetworkInfo networkInfo;
  final CategoriesMapper mapper;

  CategoriesRepositoryImpl(
    this.remoteDatasource,
    this.localDatasource,
    this.networkInfo,
    this.mapper,
  );

  @override
  Future<Results<List<Category>>> getCategories() async {
    return safeApiCall<List<Category>>(() async {
      var connected = await networkInfo.isConnected;
      if (connected) {
        var categories = await remoteDatasource.getCategoriesList();
        await localDatasource.saveCategoriesList(
          mapper.mapCategoriesDtoToLocalCategories(categories),
        );
        return Results.success(
          data: mapper.mapCategoryDtoListToCategoryList(categories),
        );
      } else {
        var categories = await localDatasource.getCategoriesList();
        return Results.success(
          data: mapper.mapLocalCategoryListToCategoryList(categories),
        );
      }
    });
  }

  @override
  Future<Results<List<String>>> getBrandsList({required String category}) {
    return safeApiCall(() async {
      var connected = await networkInfo.isConnected;
      if (connected) {
        var brands = await remoteDatasource.getBrandByCategory(
          category: category,
        );
        return Results.success(data: brands);
      } else {
        return Results.error(error: NetworkError(const AppErrorMessage("")));
      }
    });
  }
}
