import 'package:isar/isar.dart';

part 'local_category.g.dart';

@collection
class LocalCategory {
  LocalCategory({this.categoryId, this.name, this.icon});

  Id id = Isar.autoIncrement;
  String? categoryId;
  String? name;
  String? icon;
}
