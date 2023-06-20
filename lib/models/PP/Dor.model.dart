import 'dart:convert';

class DorModel {
  final String local;
  final double intensidade;

  DorModel({
    required this.local,
    required this.intensidade,
  });

  bool? get isNotEmpty => null;

  Map<String, dynamic> toJson() {
    return {
      'local': local,
      'intensidade': intensidade,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
