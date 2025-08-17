// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i497;

import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:flutter/material.dart' as _i409;
import 'package:flutter/services.dart' as _i281;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:isar/isar.dart' as _i338;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/products/data/datasource/contract/categories_local_datasource.dart'
    as _i271;
import '../../features/products/data/datasource/contract/categories_remote_datasource.dart'
    as _i949;
import '../../features/products/data/datasource/contract/products_local_datasource.dart'
    as _i637;
import '../../features/products/data/datasource/contract/products_remote_datasource.dart'
    as _i622;
import '../../features/products/data/datasource/impl/categories_local_datasource_impl.dart'
    as _i305;
import '../../features/products/data/datasource/impl/categories_remote_datasource_impl.dart'
    as _i245;
import '../../features/products/data/datasource/impl/products_local_datasource_impl.dart'
    as _i769;
import '../../features/products/data/datasource/impl/products_remote_datasource_impl.dart'
    as _i1025;
import '../../features/products/data/mappers/categories_mapper.dart' as _i834;
import '../../features/products/data/mappers/products_mapper.dart' as _i911;
import '../../features/products/data/repository/categories_repository_impl.dart'
    as _i295;
import '../../features/products/data/repository/products_repository_impl.dart'
    as _i701;
import '../../features/products/domain/repository/categories_repository.dart'
    as _i579;
import '../../features/products/domain/repository/products_repository.dart'
    as _i822;
import '../../features/products/domain/use_case/add_all_saved_items_to_cart_use_case.dart'
    as _i232;
import '../../features/products/domain/use_case/get_brands_by_category_use_case.dart'
    as _i309;
import '../../features/products/domain/use_case/get_categories_use_case.dart'
    as _i1014;
import '../../features/products/domain/use_case/get_product_details_use_case.dart'
    as _i721;
import '../../features/products/domain/use_case/get_products_use_case.dart'
    as _i1071;
import '../../features/products/domain/use_case/get_saved_items_use_case.dart'
    as _i548;
import '../../features/products/domain/use_case/search_products_use_case.dart'
    as _i163;
import '../../features/products/domain/use_case/update_product_order_quantitiy_use_case.dart'
    as _i522;
import '../../features/products/domain/use_case/update_product_saved_use_case.dart'
    as _i179;
import '../../features/products/domain/use_case/update_products_cart_use_case.dart'
    as _i966;
import '../../features/products/presentation/home/home_bloc.dart' as _i109;
import '../../features/products/presentation/product_details/product_details_bloc.dart'
    as _i1041;
import '../../features/products/presentation/search/search_bloc.dart' as _i832;
import '../network_utils/network_info.dart' as _i655;
import '../network_utils/network_info_impl.dart' as _i899;
import '../provider/app_config_provider.dart' as _i291;
import 'modules/asset_bundle_module.dart' as _i574;
import 'modules/connectivity_module.dart' as _i855;
import 'modules/isar_module.dart' as _i29;
import 'modules/preferences_module.dart' as _i329;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final isarModule = _$IsarModule();
    final connectivityModule = _$ConnectivityModule();
    final assetBundleModule = _$AssetBundleModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.provideSharePreferences(),
      preResolve: true,
    );
    await gh.factoryAsync<_i497.Directory>(
      () => isarModule.providerDirectory,
      preResolve: true,
    );
    await gh.factoryAsync<_i338.Isar>(
      () => isarModule.providerIsar,
      preResolve: true,
    );
    gh.factory<_i911.ProductsMapper>(() => _i911.ProductsMapper());
    gh.factory<_i834.CategoriesMapper>(() => _i834.CategoriesMapper());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => sharedPreferencesModule.flutterSecureStorage);
    gh.lazySingleton<_i895.Connectivity>(() => connectivityModule.connectivity);
    gh.lazySingleton<_i281.AssetBundle>(
        () => assetBundleModule.provideAssetBundle());
    gh.singleton<_i291.AppConfigProvider>(
        () => _i291.AppConfigProvider(gh<_i558.FlutterSecureStorage>()));
    gh.factory<_i622.ProductsRemoteDatasource>(
        () => _i1025.ProductsRemoteDatasourceImpl(gh<_i409.AssetBundle>()));
    gh.factory<_i637.ProductsLocalDatasource>(
        () => _i769.ProductsLocalDatasourceImpl(gh<_i338.Isar>()));
    gh.factory<_i271.CategoriesLocalDatasource>(
        () => _i305.CategoriesLocalDatasourceImpl(gh<_i338.Isar>()));
    gh.factory<_i949.CategoriesRemoteDatasource>(
        () => _i245.CategoriesRemoteDatasourceImpl(gh<_i281.AssetBundle>()));
    gh.singleton<_i655.NetworkInfo>(
        () => _i899.NetworkInfoImpl(gh<_i895.Connectivity>()));
    gh.factory<_i822.ProductsRepository>(() => _i701.ProductsRepositoryImpl(
          gh<_i622.ProductsRemoteDatasource>(),
          gh<_i637.ProductsLocalDatasource>(),
          gh<_i655.NetworkInfo>(),
          gh<_i911.ProductsMapper>(),
        ));
    gh.factory<_i579.CategoriesRepository>(() => _i295.CategoriesRepositoryImpl(
          gh<_i949.CategoriesRemoteDatasource>(),
          gh<_i271.CategoriesLocalDatasource>(),
          gh<_i655.NetworkInfo>(),
          gh<_i834.CategoriesMapper>(),
        ));
    gh.factory<_i179.UpdateProductSavedUseCase>(
        () => _i179.UpdateProductSavedUseCase(gh<_i822.ProductsRepository>()));
    gh.factory<_i1071.GetProductsUseCase>(
        () => _i1071.GetProductsUseCase(gh<_i822.ProductsRepository>()));
    gh.factory<_i966.UpdateProductsCartUseCase>(
        () => _i966.UpdateProductsCartUseCase(gh<_i822.ProductsRepository>()));
    gh.factory<_i522.UpdateProductOrderQuantityUseCase>(() =>
        _i522.UpdateProductOrderQuantityUseCase(
            gh<_i822.ProductsRepository>()));
    gh.factory<_i721.GetProductDetailsUseCase>(
        () => _i721.GetProductDetailsUseCase(gh<_i822.ProductsRepository>()));
    gh.factory<_i163.SearchProductsUseCase>(
        () => _i163.SearchProductsUseCase(gh<_i822.ProductsRepository>()));
    gh.factory<_i548.GetSavedProductsUseCase>(
        () => _i548.GetSavedProductsUseCase(gh<_i822.ProductsRepository>()));
    gh.factory<_i232.AddAllNonCartSavedToCartUseCase>(() =>
        _i232.AddAllNonCartSavedToCartUseCase(gh<_i822.ProductsRepository>()));
    gh.factory<_i1014.GetCategoriesUseCase>(
        () => _i1014.GetCategoriesUseCase(gh<_i579.CategoriesRepository>()));
    gh.factory<_i309.GetBrandsByCategoryUseCase>(() =>
        _i309.GetBrandsByCategoryUseCase(gh<_i579.CategoriesRepository>()));
    gh.factory<_i109.HomeBloc>(() => _i109.HomeBloc(
          gh<_i1014.GetCategoriesUseCase>(),
          gh<_i309.GetBrandsByCategoryUseCase>(),
          gh<_i1071.GetProductsUseCase>(),
          gh<_i966.UpdateProductsCartUseCase>(),
          gh<_i179.UpdateProductSavedUseCase>(),
          gh<_i522.UpdateProductOrderQuantityUseCase>(),
          gh<_i548.GetSavedProductsUseCase>(),
        ));
    gh.factory<_i1041.ProductDetailsBloc>(() => _i1041.ProductDetailsBloc(
          gh<_i721.GetProductDetailsUseCase>(),
          gh<_i522.UpdateProductOrderQuantityUseCase>(),
          gh<_i179.UpdateProductSavedUseCase>(),
          gh<_i966.UpdateProductsCartUseCase>(),
        ));
    gh.factory<_i832.SearchBloc>(
        () => _i832.SearchBloc(gh<_i163.SearchProductsUseCase>()));
    return this;
  }
}

class _$SharedPreferencesModule extends _i329.SharedPreferencesModule {}

class _$IsarModule extends _i29.IsarModule {}

class _$ConnectivityModule extends _i855.ConnectivityModule {}

class _$AssetBundleModule extends _i574.AssetBundleModule {}
