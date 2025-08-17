class DealsOfTheDayDto {
  DealsOfTheDayDto({
      this.date, 
      this.items,});

  DealsOfTheDayDto.fromJson(dynamic json) {
    date = json['date'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  String? date;
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Items {
  Items({
      this.productId, 
      this.dealPrice, 
      this.endsAt,});

  Items.fromJson(dynamic json) {
    productId = json['productId'];
    dealPrice = json['dealPrice'];
    endsAt = json['endsAt'];
  }
  String? productId;
  num? dealPrice;
  String? endsAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    map['dealPrice'] = dealPrice;
    map['endsAt'] = endsAt;
    return map;
  }

}