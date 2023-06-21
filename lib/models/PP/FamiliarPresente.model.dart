import 'dart:convert';

class FamiliarPresente {
  final String nome;

  FamiliarPresente({
    required this.nome,
  });

  factory FamiliarPresente.fromJson(Map<String, dynamic> json) {
    return FamiliarPresente(
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
