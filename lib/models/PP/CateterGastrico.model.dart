import 'dart:convert';

class CateterGastricoModel {
  final String tipo;
  final String profissional;

  CateterGastricoModel({
    required this.tipo,
    required this.profissional,
  });

  Map<String, dynamic> toJson() {
    return {
      'profissional': profissional,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
