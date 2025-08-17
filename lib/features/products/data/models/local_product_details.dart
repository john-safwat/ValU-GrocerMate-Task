import 'package:isar/isar.dart';

part 'local_product_details.g.dart';

@collection
class LocalProductDetails {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? productId;

  String? title;
  String? brand;
  double? price;
  double? originalPrice;
  int? stock;
  List<String>? images;
  String? description;
  EmbeddedNutrition? nutrition;
  List<String>? allergens;
  List<String>? related;

  bool? isInCart;
  bool? isInSaved;
  int? orderQuantity;
}

@embedded
class EmbeddedNutrition {
  double? calories;
  double? protein;
  double? fat;
  double? carbs;
}