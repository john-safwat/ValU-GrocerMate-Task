import 'package:flutter_test/flutter_test.dart';
import 'package:valu_task/features/products/domain/entity/category.dart';

void main() {
  group('Category', () {
    test('constructor assigns id and name correctly', () {
      final category = Category(id: '123', name: 'Electronics');
      expect(category.id, '123');
      expect(category.name, 'Electronics');
    });

    test('constructor uses default empty strings when no values are provided', () {
      final category = Category();
      expect(category.id, '');
      expect(category.name, '');
    });
  });
}
