import 'dart:convert';

class OxigenioModel {
  final String tipo;
  final double litrosMinuto;

  OxigenioModel({
    required this.tipo,
    required this.litrosMinuto,
  }) : assert(tipo == 'MAF' || tipo == 'Catéter');

  factory OxigenioModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return OxigenioModel(
        tipo: '',
        litrosMinuto: 0,
      );
    }

    return OxigenioModel(
      tipo: json['tipo'],
      litrosMinuto: json['litrosMinuto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'litrosMinuto': litrosMinuto,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
