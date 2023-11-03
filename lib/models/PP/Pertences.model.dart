import 'dart:convert';

class PertencesModel {
  final String nome;
  final String parentesco;

  PertencesModel({
    required this.nome,
    required this.parentesco,
  });

  factory PertencesModel.fromJson(Map<String, dynamic> json) {
    return PertencesModel(
      nome: json['nome'],
      parentesco: json['parentesco'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'parentesco': parentesco,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
