import 'dart:convert';

class GestanteModel {
  final String tipoGestacao;
  final bool perdasVW;
  final String ig;
  final String bcf;

  GestanteModel({
    required this.tipoGestacao,
    required this.perdasVW,
    required this.ig,
    required this.bcf,
  });

  factory GestanteModel.fromJson(Map<String, dynamic> json) {
    return GestanteModel(
      tipoGestacao: json['tipoGestacao'],
      perdasVW: json['perdasVW'],
      ig: json['ig'],
      bcf: json['bcf'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tipoGestacao': tipoGestacao,
      'perdasVW': perdasVW,
      'ig': ig,
      'bcf': bcf,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
