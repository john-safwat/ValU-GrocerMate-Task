class CategoryDto {
  CategoryDto({
      this.id, 
      this.name, 
      this.icon,});

  CategoryDto.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }
  String? id;
  String? name;
  String? icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['icon'] = icon;
    return map;
  }

}