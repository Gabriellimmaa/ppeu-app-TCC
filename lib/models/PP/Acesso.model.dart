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
      central: json['central'] == null
          ? null
          : AcessoCentral.fromJson(json['central']),
      periferico: json['periferico'] == null
          ? null
          : AcessoPeriferico.fromJson(json['periferico']),
      intraosseo: json['intraosseo'] == null
          ? null
          : AcessoIntraosseo.fromJson(json['intraosseo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'central': central?.toJson(),
      'periferico': periferico?.toJson(),
      'intraosseo': intraosseo?.toJson(),
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

  Map<String, dynamic> toJson() {
    return {
      'local': local,
      'profissional': profissional,
      'horario': horario,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'local': local,
      'profissional': profissional,
      'horario': horario,
      'numeroDispositivoIntravenoso': numeroDispositivoIntravenoso,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'local': local,
      'profissional': profissional,
      'horario': horario,
    };
  }
}
