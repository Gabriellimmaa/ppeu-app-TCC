import 'dart:convert';

class SintomasModel {
  final String horario;
  final bool dorToracica;
  final bool deficitMotor;
  final String? local;
  final String outros;

  SintomasModel({
    required this.horario,
    required this.dorToracica,
    required this.deficitMotor,
    required this.local,
    required this.outros,
  });

  Map<String, dynamic> toJson() {
    return {
      'horario': horario,
      'dorToracica': dorToracica,
      'deficitMotor': deficitMotor,
      'local': local,
      'outros': outros,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
