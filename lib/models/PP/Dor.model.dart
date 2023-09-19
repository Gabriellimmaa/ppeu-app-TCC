import 'dart:convert';

class DorModel {
  final String local;
  final double intensidade;

  DorModel({
    required this.local,
    required this.intensidade,
  });

  bool? get isNotEmpty => null;

  factory DorModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return DorModel(
        local: '',
        intensidade: 1.0,
      );
    }
    return DorModel(
      local: json['local'],
      intensidade: json['intensidade'],
    );
  }

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
