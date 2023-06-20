import 'dart:convert';

class PCRModel {
  final String ciclos;
  final PCRMedicacao? medicacoes;
  final bool cardioversaoOuDesfribilacao;

  PCRModel({
    required this.ciclos,
    required this.medicacoes,
    required this.cardioversaoOuDesfribilacao,
  });

  Map<String, dynamic> toJson() {
    return {
      'ciclos': ciclos,
      'medicacoes': medicacoes?.toJson(),
      'cardioversaoOuDesfribilacao': cardioversaoOuDesfribilacao,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class PCRMedicacao {
  final String nome;
  final String dose;
  final String horario;

  PCRMedicacao({
    required this.nome,
    required this.dose,
    required this.horario,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'dose': dose,
      'horario': horario,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
