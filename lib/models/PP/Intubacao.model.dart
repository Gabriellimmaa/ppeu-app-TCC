import 'dart:convert';

class IntubacaoModel {
  final String horario;
  final String numeroTubo;
  final String responsavel;

  IntubacaoModel({
    required this.horario,
    required this.numeroTubo,
    required this.responsavel,
  });

  Map<String, dynamic> toJson() {
    return {
      'horario': horario,
      'numeroTubo': numeroTubo,
      'responsavel': responsavel,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
