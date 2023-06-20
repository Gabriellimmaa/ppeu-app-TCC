import 'dart:convert';
import 'package:ppue/models/PP/Acesso.model.dart';
import 'package:ppue/models/PP/CateterGastrico.model.dart';
import 'package:ppue/models/PP/CateterVesical.model.dart';
import 'package:ppue/models/PP/Dor.model.dart';
import 'package:ppue/models/PP/DrenoTorax.model.dart';
import 'package:ppue/models/PP/FamiliarPresente.model.dart';
import 'package:ppue/models/PP/Gestante.model.dart';
import 'package:ppue/models/PP/Intubacao.model.dart';
import 'package:ppue/models/PP/Oxigenio.model.dart';
import 'package:ppue/models/PP/Pcr.model.dart';
import 'package:ppue/models/PP/Pertences.model.dart';
import 'package:ppue/models/PP/ResponsavelRecebimento.model.dart';
import 'package:ppue/models/PP/Sintomas.model.dart';

class PPModel {
  // Form Identificacao paciente
  final IdentificacaoModel identificacao;
  // Form Situacao
  final SituacaoModel situacao;
  // Form Breve Historico
  final BreveHistoricoModel breveHistorico;
  // Form Avaliacao
  final AvaliacaoModel avaliacao;
  // Form Recomendacoes
  final RecomendacoesModel recomendacoes;

  PPModel({
    required this.identificacao,
    required this.situacao,
    required this.breveHistorico,
    required this.avaliacao,
    required this.recomendacoes,
  });

  Map<String, dynamic> toJson() {
    return {
      'identificacao': identificacao.toJson(),
      'situacao': situacao.toJson(),
      'breveHistorico': breveHistorico.toJson(),
      'avaliacao': avaliacao.toJson(),
      'recomendacoes': recomendacoes.toJson(),
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class IdentificacaoModel {
  final String nome;
  final String idade;
  final String dataNascimento;
  final String nomeMae;
  final String sexo;
  final String formaEncaminhamento;

  IdentificacaoModel({
    required this.nome,
    required this.idade,
    required this.dataNascimento,
    required this.nomeMae,
    required this.sexo,
    required this.formaEncaminhamento,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'idade': idade,
      'dataNascimento': dataNascimento,
      'nomeMae': nomeMae,
      'sexo': sexo,
      'formaEncaminhamento': formaEncaminhamento,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class SituacaoModel {
  final String origem;
  final SintomasModel sintomas;
  final String clinica;
  final String trauma;
  final GestanteModel gestante;
  final String hipoteseDiagnostico;
  final String enfermeiroResponsavelTransferencia;

  SituacaoModel({
    required this.origem,
    required this.sintomas,
    required this.clinica,
    required this.trauma,
    required this.gestante,
    required this.hipoteseDiagnostico,
    required this.enfermeiroResponsavelTransferencia,
  });

  Map<String, dynamic> toJson() {
    return {
      'origem': origem,
      'sintomas': sintomas.toJson(),
      'clinica': clinica,
      'trauma': trauma,
      'gestante': gestante.toJson(),
      'hipoteseDiagnostico': hipoteseDiagnostico,
      'enfermeiroResponsavelTransferencia': enfermeiroResponsavelTransferencia,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class BreveHistoricoModel {
  final String historicaClinica;
  final String? alergias;
  final String? comorbidades;
  final String? vicios;
  final String? medicamentoEmUso;
  final String? historicoInternacoes;
  final String? cirurgiaPrevia;
  final String? lesoes;
  final String? alteracoesLaboratoriais;
  final String precaucoes;
  final String? jejum;

  BreveHistoricoModel({
    required this.historicaClinica,
    required this.alergias,
    required this.comorbidades,
    required this.vicios,
    required this.medicamentoEmUso,
    required this.historicoInternacoes,
    required this.cirurgiaPrevia,
    required this.lesoes,
    required this.alteracoesLaboratoriais,
    required this.precaucoes,
    required this.jejum,
  });

  Map<String, dynamic> toJson() {
    return {
      'historicaClinica': historicaClinica,
      'alergias': alergias,
      'comorbidades': comorbidades,
      'vicios': vicios,
      'medicamentoEmUso': medicamentoEmUso,
      'historicoInternacoes': historicoInternacoes,
      'cirurgiaPrevia': cirurgiaPrevia,
      'lesoes': lesoes,
      'alteracoesLaboratoriais': alteracoesLaboratoriais,
      'precaucoes': precaucoes,
      'jejum': jejum,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class AvaliacaoModel {
  final DorModel? dor;
  final String pa;
  final String temperatura;
  final String fr;
  final String fc;
  final String glicemia;
  final String sp02;
  final double ao;
  final double rv;
  final double rm;
  final String avdi;
  final String pupilas;
  final IntubacaoModel? intubacao;
  final OxigenioModel? oxigenio;
  final String? nomeMedicao;
  final AcessoModel acesso;
  final DrenoToraxModel? drenoTorax;
  final CateterGastricoModel? cateterGastrico;
  final CateterVisicalModel? cateterVesical;
  final PCRModel? pcr;
  final String? ecg;
  final String outrasAnotacoes;

  AvaliacaoModel({
    required this.dor,
    required this.pa,
    required this.temperatura,
    required this.fr,
    required this.fc,
    required this.glicemia,
    required this.sp02,
    required this.ao,
    required this.rv,
    required this.rm,
    required this.avdi,
    required this.pupilas,
    required this.intubacao,
    required this.oxigenio,
    required this.nomeMedicao,
    required this.acesso,
    required this.drenoTorax,
    required this.cateterGastrico,
    required this.cateterVesical,
    required this.pcr,
    required this.ecg,
    required this.outrasAnotacoes,
  });

  Map<String, dynamic> toJson() {
    return {
      'dor': dor?.toJson(),
      'pa': pa,
      'temperatura': temperatura,
      'fr': fr,
      'fc': fc,
      'glicemia': glicemia,
      'sp02': sp02,
      'ao': ao,
      'rv': rv,
      'rm': rm,
      'avdi': avdi,
      'pupilas': pupilas,
      'intubacao': intubacao?.toJson(),
      'oxigenio': oxigenio?.toJson(),
      'nomeMedicao': nomeMedicao,
      'acesso': acesso.toJson(),
      'drenoTorax': drenoTorax?.toJson(),
      'cateterGastrico': cateterGastrico,
      'cateterVesical': cateterVesical?.toJson(),
      'pcr': pcr?.toJson(),
      'ecg': ecg,
      'outrasAnotacoes': outrasAnotacoes,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class RecomendacoesModel {
  final String encaminhamento;
  final ResponsavelRecebimento responsavelRecebimento;
  final List<FamiliarPresente>? familiarPresente;
  final Pertences? pertences;

  RecomendacoesModel({
    required this.encaminhamento,
    required this.responsavelRecebimento,
    required this.familiarPresente,
    required this.pertences,
  });

  Map<String, dynamic> toJson() {
    return {
      'encaminhamento': encaminhamento,
      'responsavelRecebimento': responsavelRecebimento,
      'familiarPresente':
          familiarPresente?.map((e) => e.toJson()).toList() ?? [],
      'pertences': pertences?.toJson(),
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
