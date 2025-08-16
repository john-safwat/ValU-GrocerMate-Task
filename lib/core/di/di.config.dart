// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i497;

import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:isar/isar.dart' as _i338;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../network_utils/network_info.dart' as _i655;
import '../network_utils/network_info_impl.dart' as _i899;
import '../provider/app_config_provider.dart' as _i291;
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
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => sharedPreferencesModule.flutterSecureStorage);
    gh.lazySingleton<_i895.Connectivity>(() => connectivityModule.connectivity);
    gh.singleton<_i291.AppConfigProvider>(
        () => _i291.AppConfigProvider(gh<_i558.FlutterSecureStorage>()));
    gh.singleton<_i655.NetworkInfo>(
        () => _i899.NetworkInfoImpl(gh<_i895.Connectivity>()));
    return this;
  }
}

class _$SharedPreferencesModule extends _i329.SharedPreferencesModule {}

class _$IsarModule extends _i29.IsarModule {}

class _$ConnectivityModule extends _i855.ConnectivityModule {}
