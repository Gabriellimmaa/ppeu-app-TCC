import 'dart:convert';

class CateterGastricoModel {
  final String tipo;
  final String profissional;

  CateterGastricoModel({
    required this.tipo,
    required this.profissional,
  });

  factory CateterGastricoModel.fromJson(Map<String, dynamic> json) {
    return CateterGastricoModel(
      tipo: json['tipo'],
      profissional: json['profissional'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'profissional': profissional,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
