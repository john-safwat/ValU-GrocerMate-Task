class ChangeInPriceDto {
  ChangeInPriceDto({
      this.productId, 
      this.history,});

  ChangeInPriceDto.fromJson(dynamic json) {
    productId = json['productId'];
    history = json['history'] != null ? json['history'].cast<num>() : [];
  }
  String? productId;
  List<num>? history;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    map['history'] = history;
    return map;
  }

}