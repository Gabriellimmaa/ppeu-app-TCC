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

  factory IntubacaoModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return IntubacaoModel(
        horario: '',
        numeroTubo: '',
        responsavel: '',
      );
    }

    return IntubacaoModel(
      horario: json['horario'],
      numeroTubo: json['numeroTubo'],
      responsavel: json['responsavel'],
    );
  }

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
