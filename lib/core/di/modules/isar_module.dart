import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:valu_task/core/di/di.dart';

@module
abstract class IsarModule {
  @preResolve
  Future<Directory> get providerDirectory async =>
      await getApplicationDocumentsDirectory();
  @preResolve
  Future<Isar> get providerIsar async =>
      await Isar.open([], directory: getIt<Directory>().path);
}
