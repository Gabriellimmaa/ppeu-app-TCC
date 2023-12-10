import 'dart:convert';

class MobileUnitModel {
  int id;
  String name;
  int amount;
  String image;

  MobileUnitModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'amount': amount, 'image': image};
  }

  factory MobileUnitModel.fromJson(Map<String, dynamic> json) {
    return MobileUnitModel(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      image: json['image'],
    );
  }

  factory MobileUnitModel.fromJsonString(String jsonString) {
    return MobileUnitModel.fromJson(jsonDecode(jsonString));
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
