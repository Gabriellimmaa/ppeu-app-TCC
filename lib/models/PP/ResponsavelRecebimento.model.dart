import 'dart:convert';

class ResponsavelRecebimentoModel {
  final String nome;
  final String cpf;
  final String cargo;

  ResponsavelRecebimentoModel({
    required this.nome,
    required this.cpf,
    required this.cargo,
  });

  factory ResponsavelRecebimentoModel.fromJson(Map<String, dynamic> json) {
    return ResponsavelRecebimentoModel(
      nome: json['nome'],
      cpf: json['cpf'],
      cargo: json['cargo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'cpf': cpf,
      'cargo': cargo,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  split(String s) {}
}
