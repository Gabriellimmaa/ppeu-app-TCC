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
