class ProductDetailsDto {
  ProductDetailsDto({
      this.id, 
      this.title, 
      this.brand, 
      this.price, 
      this.originalPrice, 
      this.stock, 
      this.images, 
      this.description, 
      this.nutrition, 
      this.allergens, 
      this.related,});

  ProductDetailsDto.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    brand = json['brand'];
    price = json['price'];
    originalPrice = json['originalPrice'];
    stock = json['stock'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    description = json['description'];
    nutrition = json['nutrition'] != null ? Nutrition.fromJson(json['nutrition']) : null;
    allergens = json['allergens'] != null ? json['allergens'].cast<String>() : [];
    related = json['related'] != null ? json['related'].cast<String>() : [];
  }
  String? id;
  String? title;
  String? brand;
  num? price;
  num? originalPrice;
  num? stock;
  List<String>? images;
  String? description;
  Nutrition? nutrition;
  List<String>? allergens;
  List<String>? related;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['brand'] = brand;
    map['price'] = price;
    map['originalPrice'] = originalPrice;
    map['stock'] = stock;
    map['images'] = images;
    map['description'] = description;
    if (nutrition != null) {
      map['nutrition'] = nutrition?.toJson();
    }
    map['allergens'] = allergens;
    map['related'] = related;
    return map;
  }

}

class Nutrition {
  Nutrition({
      this.calories, 
      this.protein, 
      this.fat, 
      this.carbs,});

  Nutrition.fromJson(dynamic json) {
    calories = json['calories'];
    protein = json['protein'];
    fat = json['fat'];
    carbs = json['carbs'];
  }
  num? calories;
  num? protein;
  num? fat;
  num? carbs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['calories'] = calories;
    map['protein'] = protein;
    map['fat'] = fat;
    map['carbs'] = carbs;
    return map;
  }

}