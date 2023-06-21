import 'dart:convert';

class ResponsavelRecebimento {
  final String nome;
  final String cpf;
  final String cargo;

  ResponsavelRecebimento({
    required this.nome,
    required this.cpf,
    required this.cargo,
  });

  factory ResponsavelRecebimento.fromJson(Map<String, dynamic> json) {
    return ResponsavelRecebimento(
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
}
