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
