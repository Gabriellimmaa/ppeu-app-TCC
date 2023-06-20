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
