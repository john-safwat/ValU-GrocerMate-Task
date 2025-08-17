import 'package:isar/isar.dart';

part 'local_product.g.dart';

@collection
class LocalProduct {
  LocalProduct({
    this.id,
    this.title,
    this.brand,
    this.price,
    this.originalPrice,
    this.stock,
    this.image,
    this.badges,
    this.categoryId,
    this.rating,
    this.orderQuantity
  });

  Id productId = Isar.autoIncrement;

  String? id;
  String? title;
  bool isInCart = false;
  bool isInSaved = false;
  String? brand;
  double? price;
  double? originalPrice;
  int? stock;
  int? orderQuantity = 0;
  String? image;
  List<String>? badges;
  String? categoryId;
  double? rating;
}
