import 'dart:convert';

class CateterVesicalModel {
  final double tamanho;
  final String horario;
  final String profissional;

  CateterVesicalModel({
    required this.tamanho,
    required this.horario,
    required this.profissional,
  });

  factory CateterVesicalModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return CateterVesicalModel(
        tamanho: 0,
        horario: '',
        profissional: '',
      );
    }

    return CateterVesicalModel(
      tamanho: json['tamanho'],
      horario: json['horario'],
      profissional: json['profissional'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tamanho': tamanho,
      'horario': horario,
      'profissional': profissional,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
