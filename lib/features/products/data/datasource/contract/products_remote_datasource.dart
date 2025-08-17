import 'package:valu_task/features/products/data/models/product_details_dto.dart';
import 'package:valu_task/features/products/data/models/products_response_dto.dart';

abstract interface class ProductsRemoteDatasource {
  Future<ProductsResponseDto> getProductsByCategory({
    required String category,
    required int page,
    required int pageSize,
  });

  Future<ProductDetailsDto> getProductDetailsById(String productId);
}
