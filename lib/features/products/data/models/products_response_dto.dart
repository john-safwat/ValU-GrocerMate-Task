class ProductsResponseDto {
  ProductsResponseDto({
      this.productDto, 
      this.page, 
      this.pageSize, 
      this.total, 
      this.sort,});

  ProductsResponseDto.fromJson(dynamic json) {
    if (json['data'] != null) {
      productDto = [];
      json['data'].forEach((v) {
        productDto?.add(ProductDto.fromJson(v));
      });
    }
    page = json['page'];
    pageSize = json['pageSize'];
    total = json['total'];
    sort = json['sort'];
  }
  List<ProductDto>? productDto;
  num? page;
  num? pageSize;
  num? total;
  String? sort;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (productDto != null) {
      map['data'] = productDto?.map((v) => v.toJson()).toList();
    }
    map['page'] = page;
    map['pageSize'] = pageSize;
    map['total'] = total;
    map['sort'] = sort;
    return map;
  }

}

class ProductDto {
  ProductDto({
      this.id, 
      this.title, 
      this.brand, 
      this.price, 
      this.originalPrice, 
      this.stock, 
      this.image, 
      this.badges, 
      this.categoryId, 
      this.rating,});

  ProductDto.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    brand = json['brand'];
    price = json['price'];
    originalPrice = json['originalPrice'];
    stock = json['stock'];
    image = json['image'];
    badges = json['badges'] != null ? json['badges'].cast<String>() : [];
    categoryId = json['categoryId'];
    rating = json['rating'];
  }
  String? id;
  String? title;
  String? brand;
  num? price;
  num? originalPrice;
  num? stock;
  String? image;
  List<String>? badges;
  String? categoryId;
  num? rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['brand'] = brand;
    map['price'] = price;
    map['originalPrice'] = originalPrice;
    map['stock'] = stock;
    map['image'] = image;
    map['badges'] = badges;
    map['categoryId'] = categoryId;
    map['rating'] = rating;
    return map;
  }

}