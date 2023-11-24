import 'dart:convert';

class PupilasFotoreacaoModel {
  final double tamanhoDireita;
  final double tamanhoEsquerda;

  PupilasFotoreacaoModel({
    required this.tamanhoDireita,
    required this.tamanhoEsquerda,
  });

  factory PupilasFotoreacaoModel.fromJson(Map<String, dynamic> json) {
    return PupilasFotoreacaoModel(
      tamanhoDireita: json['tamanhoDireita'],
      tamanhoEsquerda: json['tamanhoEsquerda'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tamanhoDireita': tamanhoDireita,
      'tamanhoEsquerda': tamanhoEsquerda,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
