class Product {
  String id;
  String title;
  String brand;
  num price;
  num originalPrice;
  num stock;
  String image;
  List<String> badges;
  String categoryId;
  num rating;
  bool isInCart;
  bool isSaved;
  int orderQuantity;
  double? dealPrice;
  double? updatePrice;
  int updatedStock;

  Product({
    this.id = '',
    this.title = '',
    this.brand = '',
    this.price = 0,
    this.originalPrice = 0,
    this.stock = 0,
    this.image = '',
    this.badges = const [],
    this.categoryId = '',
    this.rating = 0,
    this.isInCart = false,
    this.isSaved = false,
    this.orderQuantity = 0,
    this.dealPrice,
    this.updatePrice,
    this.updatedStock = 0,
  });

  Product copyWith({
    String? id,
    String? title,
    String? brand,
    num? price,
    num? originalPrice,
    num? stock,
    String? image,
    List<String>? badges,
    String? categoryId,
    num? rating,
    bool? isInCart,
    bool? isSaved,
    int? orderQuantity,
    double? dealPrice,
    int? updatedQuantity,
    double? updatePrice,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      brand: brand ?? this.brand,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      stock: stock ?? this.stock,
      image: image ?? this.image,
      badges: badges ?? this.badges,
      categoryId: categoryId ?? this.categoryId,
      rating: rating ?? this.rating,
      isInCart: isInCart ?? this.isInCart,
      isSaved: isSaved ?? this.isSaved,
      orderQuantity: orderQuantity ?? this.orderQuantity,
      dealPrice: dealPrice ?? this.dealPrice,
      updatedStock: updatedQuantity ?? this.updatedStock,
      updatePrice: updatePrice ?? this.updatePrice,
    );
  }
}

class ProductsResponse {
  List<Product> products;
  int page;
  int pageSize;
  int total;
  String sort;

  ProductsResponse({
    this.products = const [],
    this.page = 1,
    this.pageSize = 10,
    this.total = 0,
    this.sort = '',
  });

  ProductsResponse copyWith({
    List<Product>? products,
    int? page,
    int? pageSize,
    int? total,
    String? sort,
  }) {
    return ProductsResponse(
      products: products ?? this.products,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      total: total ?? this.total,
      sort: sort ?? this.sort,
    );
  }
}
