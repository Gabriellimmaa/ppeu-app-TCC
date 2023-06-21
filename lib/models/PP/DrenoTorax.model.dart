import 'dart:convert';

class DrenoToraxModel {
  final String local;
  final String numero;
  final String horario;
  final String profissional;

  DrenoToraxModel({
    required this.local,
    required this.numero,
    required this.horario,
    required this.profissional,
  });

  factory DrenoToraxModel.fromJson(Map<String, dynamic> json) {
    return DrenoToraxModel(
      local: json['local'],
      numero: json['numero'],
      horario: json['horario'],
      profissional: json['profissional'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'local': local,
      'numero': numero,
      'horario': horario,
      'profissional': profissional,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
