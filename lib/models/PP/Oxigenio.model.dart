import 'dart:convert';

class OxigenioModel {
  final String tipo;
  final double litrosMinuto;

  OxigenioModel({
    required this.tipo,
    required this.litrosMinuto,
  }) : assert(tipo == 'MAF' || tipo == 'Catater');

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
