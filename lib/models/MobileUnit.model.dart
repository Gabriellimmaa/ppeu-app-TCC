import 'dart:convert';

class MobileUnitModel {
  int id;
  String name;
  int amount;

  MobileUnitModel({
    required this.id,
    required this.name,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
    };
  }

  factory MobileUnitModel.fromJson(Map<String, dynamic> json) {
    return MobileUnitModel(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
    );
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
