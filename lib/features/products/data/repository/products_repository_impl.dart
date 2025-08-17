import 'package:injectable/injectable.dart';
import 'package:valu_task/core/base_ui/app_error_message.dart';
import 'package:valu_task/core/network_utils/app_errors.dart';
import 'package:valu_task/core/network_utils/network_info.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/core/network_utils/safe_api_call.dart';
import 'package:valu_task/features/products/data/datasource/contract/products_local_datasource.dart';
import 'package:valu_task/features/products/data/datasource/contract/products_remote_datasource.dart';
import 'package:valu_task/features/products/data/mappers/products_mapper.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';
import 'package:valu_task/features/products/domain/repository/products_repository.dart';

@Injectable(as: ProductsRepository)
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDatasource remoteDatasource;
  final ProductsLocalDatasource localDatasource;
  final NetworkInfo networkInfo;
  final ProductsMapper mapper;

  ProductsRepositoryImpl(
    this.remoteDatasource,
    this.localDatasource,
    this.networkInfo,
    this.mapper,
  );

  @override
  Future<Results<ProductsResponse>> getProductsByCategory({
    required String category,
    required int page,
    required int pageSize,
  }) async {
    return safeApiCall<ProductsResponse>(() async {
      final connected = await networkInfo.isConnected;
      if (connected) {
        final responseDto = await remoteDatasource.getProductsByCategory(
          category: category,
          page: page,
          pageSize: pageSize,
        );
        final dtos = responseDto.productDto ?? [];
        final products = <Product>[];
        for (var dto in dtos) {
          final localProduct = await localDatasource.getProductById(
            dto.id ?? '',
          );
          final isInCart = localProduct?.isInCart ?? false;
          final isSaved = localProduct?.isInSaved ?? false;
          final orderQuantity = localProduct?.orderQuantity ?? 0;
          products.add(
            mapper.mapProductDtoToProduct(
              dto,
              isInCart: isInCart,
              isSaved: isSaved,
              orderQuantity: orderQuantity,
            ),
          );
        }
        await localDatasource.saveProducts(
          mapper.mapProductDtoListToLocalProductList(dtos),
        );
        return Results.success(
          data: ProductsResponse(
            products: products,
            page: responseDto.page?.toInt() ?? page,
            pageSize: responseDto.pageSize?.toInt() ?? pageSize,
            total: responseDto.total?.toInt() ?? 0,
            sort: responseDto.sort ?? '',
          ),
        );
      } else {
        final locals = await localDatasource.getProductsByCategory(
          category: category,
        );
        return Results.success(
          data: ProductsResponse(
            products: mapper.mapLocalProductListToProductList(locals),
            page: page,
            pageSize: pageSize,
          ),
        );
      }
    });
  }

  @override
  Future<Results<void>> updateProductCart(
    String productId,
    bool isInCart,
  ) async {
    return safeApiCall(() async {
      await localDatasource.updateCart(productId, isInCart);
      await localDatasource.updateOrderQuantity(productId, isInCart ? 1 : 0);
      return const Results.success(data: null);
    });
  }

  @override
  Future<Results<void>> updateProductSaved(
    String productId,
    bool isSaved,
  ) async {
    return safeApiCall(() async {
      await localDatasource.updateSaved(productId, isSaved);
      return const Results.success(data: null);
    });
  }

  @override
  Future<Results<void>> updateProductOrderQuantity(
    String productId,
    int quantity,
  ) async {
    return safeApiCall(() async {
      await localDatasource.updateOrderQuantity(productId, quantity);
      print(quantity);
      return const Results.success(data: null);
    });
  }

  @override
  Future<Results<Product>> getProductById(String productId) async {
    return safeApiCall<Product>(() async {
      final connected = await networkInfo.isConnected;
      if (connected) {
        final detailsDto = await remoteDatasource.getProductDetailsById(
          productId,
        );
        final localProduct = await localDatasource.getProductById(productId);
        final localDetails = await localDatasource.getProductDetailsById(
          productId,
        );
        final isInCart =
            localProduct?.isInCart ?? localDetails?.isInCart ?? false;
        final isSaved =
            localProduct?.isInSaved ?? localDetails?.isInSaved ?? false;
        final orderQuantity =
            localProduct?.orderQuantity ?? localDetails?.orderQuantity ?? 0;
        await localDatasource.saveProductDetails(
          mapper.mapProductDetailsDtoToLocalProductDetails(detailsDto),
        );
        return Results.success(
          data: mapper.mapProductDetailsDtoToProduct(
            detailsDto,
            isInCart: isInCart,
            isSaved: isSaved,
            orderQuantity: orderQuantity,
          ),
        );
      } else {
        final localDetails = await localDatasource.getProductDetailsById(
          productId,
        );
        if (localDetails != null) {
          return Results.success(
            data: mapper.mapLocalProductDetailsToProduct(localDetails),
          );
        }
        final localProduct = await localDatasource.getProductById(productId);
        if (localProduct != null) {
          return Results.success(
            data: mapper.mapLocalProductToProduct(localProduct),
          );
        }
        return Results.error(
          error: NoProductError(
            const AppErrorMessage('Product not found offline'),
          ),
        );
      }
    });
  }

  @override
  Future<Results<List<Product>>> searchProducts(String query) async {
    return safeApiCall<List<Product>>(() async {
      final locals = await localDatasource.searchProducts(query);
      return Results.success(
        data: mapper.mapLocalProductListToProductList(locals),
      );
    });
  }

  @override
  Future<Results<List<Product>>> getSavedProducts() async {
    return safeApiCall<List<Product>>(() async {
      final locals = await localDatasource.getSavedProducts();
      return Results.success(
        data: mapper.mapLocalProductListToProductList(locals),
      );
    });
  }

  @override
  Future<Results<void>> addAllNonCartSavedToCart() async {
    return safeApiCall(() async {
      final savedProducts = await localDatasource.getSavedProducts();
      for (var local in savedProducts) {
        if (!local.isInCart) {
          await localDatasource.updateCart(local.id ?? '', true);
        }
      }
      return const Results.success(data: null);
    });
  }
}
