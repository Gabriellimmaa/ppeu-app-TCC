import 'dart:convert';

class FamiliarPresente {
  final String nome;

  FamiliarPresente({
    required this.nome,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
