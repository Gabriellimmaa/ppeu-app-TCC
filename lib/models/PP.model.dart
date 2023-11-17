import 'dart:convert';
import 'package:ppue/models/PP/Acesso.model.dart';
import 'package:ppue/models/PP/CateterGastrico.model.dart';
import 'package:ppue/models/PP/CateterVesical.model.dart';
import 'package:ppue/models/PP/Dor.model.dart';
import 'package:ppue/models/PP/DrenoTorax.model.dart';
import 'package:ppue/models/PP/Gestante.model.dart';
import 'package:ppue/models/PP/Intubacao.model.dart';
import 'package:ppue/models/PP/Oxigenio.model.dart';
import 'package:ppue/models/PP/Pertences.model.dart';
import 'package:ppue/models/PP/ResponsavelRecebimento.model.dart';
import 'package:ppue/models/PP/Sintomas.model.dart';

class PPModel {
  int? id;
  late final IdentificacaoModel identificacao;
  final SituacaoModel situacao;
  final BreveHistoricoModel breveHistorico;
  final AvaliacaoModel avaliacao;
  final RecomendacoesModel recomendacoes;
  String? status;
  String? createdAt;

  PPModel(
      {required this.identificacao,
      required this.situacao,
      required this.breveHistorico,
      required this.avaliacao,
      required this.recomendacoes,
      this.status,
      this.createdAt,
      this.id});

  Map<String, dynamic> toJson() {
    return {
      'identificacao': identificacao.toJson(),
      'situacao': situacao.toJson(),
      'breveHistorico': breveHistorico.toJson(),
      'avaliacao': avaliacao.toJson(),
      'recomendacoes': recomendacoes.toJson(),
    };
  }

  factory PPModel.fromJson(Map<String, dynamic> json) {
    String dateString = json['created_at'];

    String datePart = dateString.substring(0, 10);
    DateTime createdAt = DateTime.parse(datePart);
    return PPModel(
      identificacao: IdentificacaoModel.fromJson(json['identificacao']),
      situacao: SituacaoModel.fromJson(json['situacao']),
      breveHistorico: BreveHistoricoModel.fromJson(json['breveHistorico']),
      avaliacao: AvaliacaoModel.fromJson(json['avaliacao']),
      recomendacoes: RecomendacoesModel.fromJson(json['recomendacoes']),
      status: json['status'],
      createdAt:
          "${createdAt.day.toString().padLeft(2, '0')}/${createdAt.month.toString().padLeft(2, '0')}/${createdAt.year}",
      id: json['id'],
    );
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

  factory IdentificacaoModel.fromJson(Map<String, dynamic> json) {
    return IdentificacaoModel(
      nome: json['nome'],
      idade: json['idade'],
      dataNascimento: json['dataNascimento'],
      nomeMae: json['nomeMae'],
      sexo: json['sexo'],
      formaEncaminhamento: json['formaEncaminhamento'],
    );
  }

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
  final GestanteModel? gestante;
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

  factory SituacaoModel.fromJson(Map<String, dynamic> json) {
    return SituacaoModel(
      origem: json['origem'],
      sintomas: SintomasModel.fromJson(json['sintomas']),
      clinica: json['clinica'],
      trauma: json['trauma'],
      gestante: json['gestante'] == null
          ? null
          : GestanteModel.fromJson(json['gestante']),
      hipoteseDiagnostico: json['hipoteseDiagnostico'],
      enfermeiroResponsavelTransferencia:
          json['enfermeiroResponsavelTransferencia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'origem': origem,
      'sintomas': sintomas.toJson(),
      'clinica': clinica,
      'trauma': trauma,
      'gestante': gestante?.toJson(),
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

  factory BreveHistoricoModel.fromJson(Map<String, dynamic> json) {
    return BreveHistoricoModel(
      historicaClinica: json['historicaClinica'],
      alergias: json['alergias'],
      comorbidades: json['comorbidades'],
      vicios: json['vicios'],
      medicamentoEmUso: json['medicamentoEmUso'],
      historicoInternacoes: json['historicoInternacoes'],
      cirurgiaPrevia: json['cirurgiaPrevia'],
      lesoes: json['lesoes'],
      alteracoesLaboratoriais: json['alteracoesLaboratoriais'],
      precaucoes: json['precaucoes'],
      jejum: json['jejum'],
    );
  }

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
  final String? nomeMedicacao;
  final AcessoModel acesso;
  final DrenoToraxModel? drenoTorax;
  final CateterGastricoModel? cateterGastrico;
  final CateterVesicalModel? cateterVesical;
  // final PCRModel? pcr;
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
    required this.nomeMedicacao,
    required this.acesso,
    required this.drenoTorax,
    required this.cateterGastrico,
    required this.cateterVesical,
    // required this.pcr,
    required this.ecg,
    required this.outrasAnotacoes,
  });

  factory AvaliacaoModel.fromJson(Map<String, dynamic> json) {
    return AvaliacaoModel(
      dor: json['dor'] == null ? null : DorModel.fromJson(json['dor']),
      pa: json['pa'],
      temperatura: json['temperatura'],
      fr: json['fr'],
      fc: json['fc'],
      glicemia: json['glicemia'],
      sp02: json['sp02'],
      ao: json['ao'],
      rv: json['rv'],
      rm: json['rm'],
      avdi: json['avdi'],
      pupilas: json['pupilas'],
      intubacao: json['intubacao'] == null
          ? null
          : IntubacaoModel.fromJson(json['intubacao']),
      oxigenio: json['oxigenio'] == null
          ? null
          : OxigenioModel.fromJson(json['oxigenio']),
      nomeMedicacao: json['nomeMedicao'],
      acesso: AcessoModel.fromJson(json['acesso']),
      drenoTorax: json['drenoTorax'] == null
          ? null
          : DrenoToraxModel.fromJson(json['drenoTorax']),
      cateterGastrico: json['cateterGastrico'] == null
          ? null
          : CateterGastricoModel.fromJson(json['cateterGastrico']),
      cateterVesical: json['cateterVesical'] == null
          ? null
          : CateterVesicalModel.fromJson(json['cateterVesical']),
      // pcr: PCRModel.fromJson(json['pcr']),
      ecg: json['ecg'],
      outrasAnotacoes: json['outrasAnotacoes'],
    );
  }

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
      'nomeMedicao': nomeMedicacao,
      'acesso': acesso.toJson(),
      'drenoTorax': drenoTorax?.toJson(),
      'cateterGastrico': cateterGastrico,
      'cateterVesical': cateterVesical?.toJson(),
      // 'pcr': pcr?.toJson(),
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
  final ResponsavelRecebimentoModel responsavelRecebimento;
  final List<dynamic> familiarPresente;
  final PertencesModel? pertences;

  RecomendacoesModel({
    required this.encaminhamento,
    required this.responsavelRecebimento,
    required this.familiarPresente,
    required this.pertences,
  });

  factory RecomendacoesModel.fromJson(Map<String, dynamic> json) {
    return RecomendacoesModel(
      encaminhamento: json['encaminhamento'],
      responsavelRecebimento:
          ResponsavelRecebimentoModel.fromJson(json['responsavelRecebimento']),
      familiarPresente: json['familiarPresente'],
      pertences: json['pertences'] == null
          ? null
          : PertencesModel.fromJson(json['pertences']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'encaminhamento': encaminhamento,
      'responsavelRecebimento': {
        'nome': responsavelRecebimento.nome,
        'cpf': responsavelRecebimento.cpf,
        'cargo': responsavelRecebimento.cargo,
      },
      'familiarPresente': familiarPresente,
      'pertences': pertences?.toJson(),
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
