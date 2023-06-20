import 'dart:convert';

class Pertences {
  final String nome;
  final String parentesco;

  Pertences({
    required this.nome,
    required this.parentesco,
  });

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
