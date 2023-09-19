import 'dart:convert';

class AcessoModel {
  final AcessoCentral? central;
  final AcessoPeriferico? periferico;
  final AcessoIntraosseo? intraosseo;

  AcessoModel({
    required this.central,
    required this.periferico,
    required this.intraosseo,
  });

  factory AcessoModel.fromJson(Map<String, dynamic> json) {
    return AcessoModel(
      central: AcessoCentral.fromJson(json['central']),
      periferico: AcessoPeriferico.fromJson(json['periferico']),
      intraosseo: AcessoIntraosseo.fromJson(json['intraosseo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'central': central,
      'periferico': periferico,
      'intraosseo': intraosseo,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class AcessoCentral {
  final String local;
  final String profissional;
  final String horario;

  AcessoCentral({
    required this.local,
    required this.profissional,
    required this.horario,
  });

  factory AcessoCentral.fromJson(Map<String, dynamic> json) {
    return AcessoCentral(
      local: json['local'],
      profissional: json['profissional'],
      horario: json['horario'],
    );
  }
}

class AcessoPeriferico {
  final String local;
  final String profissional;
  final String horario;
  final int numeroDispositivoIntravenoso;

  AcessoPeriferico(
      {required this.local,
      required this.profissional,
      required this.horario,
      required this.numeroDispositivoIntravenoso});

  factory AcessoPeriferico.fromJson(Map<String, dynamic> json) {
    return AcessoPeriferico(
      local: json['local'],
      profissional: json['profissional'],
      horario: json['horario'],
      numeroDispositivoIntravenoso: json['numeroDispositivoIntravenoso'],
    );
  }
}

class AcessoIntraosseo {
  final String local;
  final String profissional;
  final String horario;

  AcessoIntraosseo({
    required this.local,
    required this.profissional,
    required this.horario,
  });

  factory AcessoIntraosseo.fromJson(Map<String, dynamic> json) {
    return AcessoIntraosseo(
      local: json['local'],
      profissional: json['profissional'],
      horario: json['horario'],
    );
  }
}
