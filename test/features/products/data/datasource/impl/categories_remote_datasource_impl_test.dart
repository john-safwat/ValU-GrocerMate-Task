import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:valu_task/features/products/data/datasource/impl/categories_remote_datasource_impl.dart';
import 'package:valu_task/features/products/data/models/category_dto.dart';

import 'categories_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([AssetBundle])
void main() {
  late CategoriesRemoteDatasourceImpl datasource;
  late MockAssetBundle mockAssetBundle;

  setUp(() {
    mockAssetBundle = MockAssetBundle();
    TestWidgetsFlutterBinding.ensureInitialized();
    datasource = CategoriesRemoteDatasourceImpl(mockAssetBundle);
  });

  group('CategoriesRemoteDatasourceImpl', () {
    late CategoriesRemoteDatasourceImpl datasource;
    late MockAssetBundle mockAssetBundle;

    setUp(() {
      mockAssetBundle = MockAssetBundle();
      datasource = CategoriesRemoteDatasourceImpl(mockAssetBundle);
    });

    const String testJson = '''
    [
      {"id": "1", "name": "Electronics", "icon": "Electronic gadgets"},
      {"id": "2", "name": "Clothing", "icon": "Fashion and apparel"}
    ]
    ''';

    test(
      'should return a list of CategoryDto when JSON is loaded successfully',
      () async {
        when(
          mockAssetBundle.loadString('assets/files/categories.json'),
        ).thenAnswer((_) async => testJson);

        final result = await datasource.getCategoriesList();

        expect(result, isA<List<CategoryDto>>());
        expect(result.length, 2);
        expect(result[0].id, "1");
        expect(result[0].name, 'Electronics');
        expect(result[0].icon, 'Electronic gadgets');
        expect(result[1].id, "2");
        expect(result[1].name, 'Clothing');
        expect(result[1].icon, 'Fashion and apparel');
        verify(
          mockAssetBundle.loadString('assets/files/categories.json'),
        ).called(1);
        verifyNoMoreInteractions(mockAssetBundle);
      },
    );
  });
}
