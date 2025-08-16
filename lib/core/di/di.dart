import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:valu_task/core/di/di.config.dart';

GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async => await getIt.init();
