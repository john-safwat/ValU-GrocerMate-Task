import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:valu_task/features/products/data/models/local_category.dart';

void main() {
  group('LocalCategory', () {
    test('constructor assigns values correctly', () {
      final localCategory = LocalCategory(
        categoryId: 'cat_01',
        name: 'Games',
        icon: 'game_icon',
      );
      expect(localCategory.categoryId, 'cat_01');
      expect(localCategory.name, 'Games');
      expect(localCategory.icon, 'game_icon');
      expect(localCategory.id, Isar.autoIncrement);
    });
  });
}
