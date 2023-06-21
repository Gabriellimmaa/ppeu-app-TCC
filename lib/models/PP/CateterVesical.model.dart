import 'dart:convert';

class CateterVisicalModel {
  final double tamanho;
  final String horario;
  final String profissional;

  CateterVisicalModel({
    required this.tamanho,
    required this.horario,
    required this.profissional,
  });

  factory CateterVisicalModel.fromJson(Map<String, dynamic> json) {
    return CateterVisicalModel(
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
