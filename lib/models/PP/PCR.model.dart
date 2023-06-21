import 'dart:convert';

class PCRModel {
  final String ciclos;
  final List<PCRMedicacao>? medicacoes;
  final bool cardioversaoOuDesfribilacao;

  PCRModel({
    required this.ciclos,
    required this.medicacoes,
    required this.cardioversaoOuDesfribilacao,
  });

  Map<String, dynamic> toJson() {
    return {
      'ciclos': ciclos,
      'medicacoes': medicacoes?.map((e) => e.toJson()).toList(),
      'cardioversaoOuDesfribilacao': cardioversaoOuDesfribilacao,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory PCRModel.fromJson(Map<String, dynamic> json) {
    return PCRModel(
      ciclos: json['ciclos'],
      medicacoes: json['medicacoes'] != null
          ? (json['medicacoes'] as List)
              .map((e) => PCRMedicacao.fromJson(e))
              .toList()
          : null,
      cardioversaoOuDesfribilacao: json['cardioversaoOuDesfribilacao'],
    );
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

  factory PCRMedicacao.fromJson(Map<String, dynamic> json) {
    return PCRMedicacao(
      nome: json['nome'],
      dose: json['dose'],
      horario: json['horario'],
    );
  }

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
