class AppConfiguration {
  AppConfiguration({
      this.showDeals, 
      this.enablePriceRevalidation, 
      this.taxRate, 
      this.currency, 
      this.deliveryFee, 
      this.freeDeliveryThreshold, 
      this.searchDebounceMs, 
      this.enableSavedForLater, 
      this.maintenanceMode,});

  AppConfiguration.fromJson(dynamic json) {
    showDeals = json['showDeals'];
    enablePriceRevalidation = json['enablePriceRevalidation'];
    taxRate = json['taxRate'];
    currency = json['currency'];
    deliveryFee = json['deliveryFee'];
    freeDeliveryThreshold = json['freeDeliveryThreshold'];
    searchDebounceMs = json['searchDebounceMs'];
    enableSavedForLater = json['enableSavedForLater'];
    maintenanceMode = json['maintenanceMode'];
  }
  bool? showDeals;
  bool? enablePriceRevalidation;
  double? taxRate;
  String? currency;
  double? deliveryFee;
  double? freeDeliveryThreshold;
  num? searchDebounceMs;
  bool? enableSavedForLater;
  bool? maintenanceMode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['showDeals'] = showDeals;
    map['enablePriceRevalidation'] = enablePriceRevalidation;
    map['taxRate'] = taxRate;
    map['currency'] = currency;
    map['deliveryFee'] = deliveryFee;
    map['freeDeliveryThreshold'] = freeDeliveryThreshold;
    map['searchDebounceMs'] = searchDebounceMs;
    map['enableSavedForLater'] = enableSavedForLater;
    map['maintenanceMode'] = maintenanceMode;
    return map;
  }

}