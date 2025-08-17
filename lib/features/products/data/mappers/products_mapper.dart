import 'package:injectable/injectable.dart';
import 'package:valu_task/features/products/data/models/local_product.dart';
import 'package:valu_task/features/products/data/models/local_product_details.dart';
import 'package:valu_task/features/products/data/models/products_response_dto.dart';
import 'package:valu_task/features/products/data/models/product_details_dto.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';

@injectable
class ProductsMapper {
  Product mapProductDtoToProduct(
      ProductDto dto, {
        required bool isInCart,
        required bool isSaved,
        required int orderQuantity,
      }) {
    if (dto.id == null || dto.title == null) {
      throw Exception('Invalid ProductDto: id or title is null');
    }
    return Product(
      id: dto.id!,
      title: dto.title!,
      brand: dto.brand ?? '',
      price: dto.price ?? 0,
      originalPrice: dto.originalPrice ?? 0,
      stock: dto.stock ?? 0,
      image: dto.image ?? '',
      badges: dto.badges ?? [],
      categoryId: dto.categoryId ?? '',
      rating: dto.rating ?? 0,
      isInCart: isInCart,
      isSaved: isSaved,
      orderQuantity: orderQuantity,
    );
  }

  Product mapProductDetailsDtoToProduct(
      ProductDetailsDto dto, {
        required bool isInCart,
        required bool isSaved,
        required int orderQuantity,
      }) {
    if (dto.id == null || dto.title == null) {
      throw Exception('Invalid ProductDetailsDto: id or title is null');
    }
    return Product(
      id: dto.id!,
      title: dto.title!,
      brand: dto.brand ?? '',
      price: dto.price ?? 0,
      originalPrice: dto.originalPrice ?? 0,
      stock: dto.stock ?? 0,
      image: dto.images?.isNotEmpty == true ? dto.images!.first : '',
      badges: [], // ProductDetailsDto doesn't have badges, so use empty list
      categoryId: '', // ProductDetailsDto doesn't have categoryId
      rating: 0, // ProductDetailsDto doesn't have rating
      isInCart: isInCart,
      isSaved: isSaved,
      orderQuantity: orderQuantity,
    );
  }

  Product mapLocalProductToProduct(LocalProduct local) {
    return Product(
      id: local.id ?? '',
      title: local.title ?? '',
      brand: local.brand ?? '',
      price: local.price ?? 0,
      originalPrice: local.originalPrice ?? 0,
      stock: local.stock ?? 0,
      image: local.image ?? '',
      badges: local.badges ?? [],
      categoryId: local.categoryId ?? '',
      rating: local.rating ?? 0,
      isInCart: local.isInCart,
      isSaved: local.isInSaved,
      orderQuantity: local.orderQuantity ?? 0,
    );
  }

  Product mapLocalProductDetailsToProduct(LocalProductDetails local) {
    return Product(
      id: local.productId ?? '',
      title: local.title ?? '',
      brand: local.brand ?? '',
      price: local.price ?? 0,
      originalPrice: local.originalPrice ?? 0,
      stock: local.stock ?? 0,
      image: local.images?.isNotEmpty == true ? local.images!.first : '',
      badges: [], // LocalProductDetails doesn't have badges
      categoryId: '', // LocalProductDetails doesn't have categoryId
      rating: 0, // LocalProductDetails doesn't have rating
      isInCart: local.isInCart ?? false,
      isSaved: local.isInSaved ?? false,
      orderQuantity: local.orderQuantity ?? 0,
    );
  }

  LocalProduct mapProductDtoToLocalProduct(ProductDto dto) {
    return LocalProduct()
      ..id = dto.id
      ..title = dto.title
      ..brand = dto.brand
      ..price = dto.price?.toDouble()
      ..originalPrice = dto.originalPrice?.toDouble()
      ..stock = dto.stock?.toInt()
      ..image = dto.image
      ..badges = dto.badges
      ..categoryId = dto.categoryId
      ..rating = dto.rating?.toDouble()
      ..isInCart = false
      ..isInSaved = false
      ..orderQuantity = 0;
  }

  LocalProductDetails mapProductDetailsDtoToLocalProductDetails(ProductDetailsDto dto) {
    return LocalProductDetails()
      ..productId = dto.id
      ..title = dto.title
      ..brand = dto.brand
      ..price = dto.price?.toDouble()
      ..originalPrice = dto.originalPrice?.toDouble()
      ..stock = dto.stock?.toInt()
      ..images = dto.images
      ..description = dto.description
      ..nutrition = EmbeddedNutrition()
      ..allergens = dto.allergens
      ..related = dto.related
      ..isInCart = false
      ..isInSaved = false
      ..orderQuantity = 0;
  }

  List<LocalProduct> mapProductDtoListToLocalProductList(
      List<ProductDto> dtos,
      ) {
    return dtos.map(mapProductDtoToLocalProduct).toList();
  }

  List<Product> mapLocalProductListToProductList(List<LocalProduct> locals) {
    return locals.map(mapLocalProductToProduct).toList();
  }
}