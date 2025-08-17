import 'package:flutter_test/flutter_test.dart';
import 'package:valu_task/features/products/data/models/category_dto.dart';

void main() {
  group('CategoryDto', () {
    test('constructor assigns values correctly', () {
      final dto = CategoryDto(id: '1', name: 'Books', icon: 'book_icon');
      expect(dto.id, '1');
      expect(dto.name, 'Books');
      expect(dto.icon, 'book_icon');
    });

    test('fromJson creates a valid object from a map', () {
      final json = {'id': '2', 'name': 'Movies', 'icon': 'movie_icon'};
      final dto = CategoryDto.fromJson(json);
      expect(dto.id, '2');
      expect(dto.name, 'Movies');
      expect(dto.icon, 'movie_icon');
    });

    test('toJson returns a valid map', () {
      final dto = CategoryDto(id: '3', name: 'Music', icon: 'music_icon');
      final json = dto.toJson();
      expect(json['id'], '3');
      expect(json['name'], 'Music');
      expect(json['icon'], 'music_icon');
    });
  });
}
