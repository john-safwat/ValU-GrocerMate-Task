class ChangeInStockDto {
  ChangeInStockDto({
      this.stocks, 
      this.timestamp,});

  ChangeInStockDto.fromJson(Map<String , dynamic> json) {
    if (json['stocks'] != null) {
      stocks = [];
      json['stocks'].forEach((v) {
        stocks?.add(Stocks.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }
  List<Stocks>? stocks;
  String? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (stocks != null) {
      map['stocks'] = stocks?.map((v) => v.toJson()).toList();
    }
    map['timestamp'] = timestamp;
    return map;
  }

}

class Stocks {
  Stocks({
      this.productId, 
      this.stock,});

  Stocks.fromJson(dynamic json) {
    productId = json['productId'];
    stock = json['stock'];
  }
  String? productId;
  num? stock;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    map['stock'] = stock;
    return map;
  }

}