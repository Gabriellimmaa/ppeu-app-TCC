import 'package:flutter/cupertino.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:ppue/models/PP/Acesso.model.dart';
import 'package:ppue/models/PP/CateterVesical.model.dart';
import 'package:ppue/models/PP/DrenoTorax.model.dart';
import 'package:ppue/models/PP/FamiliarPresente.model.dart';
import 'package:ppue/models/PP/Gestante.model.dart';
import 'package:ppue/models/PP/Intubacao.model.dart';
import 'package:ppue/models/PP/Oxigenio.model.dart';
import 'package:ppue/models/PP/PCR.model.dart';
import 'package:ppue/models/PP/Pertences.model.dart';
import 'package:ppue/models/PP/ResponsavelRecebimento.model.dart';
import 'package:ppue/models/PP/Sintomas.model.dart';

final spacingRow = SizedBox(height: 16);
final spacingColumn = SizedBox(width: 16);

List<String> optionsOrigem = ['Residência', 'Via pública', 'Transferência'];
List<String> optionsTipoTrauma = [
  'Acidente de trânsito',
  'Agressão',
  'FAB/FAF',
  'Intoxicção',
  'Queda',
  'Queimadura',
  'Outros'
];
List<String> optionsClinica = [
  'Abdominal',
  'Cardíaco',
  'Metabólico',
  'Neurológico',
  'Pulmonar/respiratório',
  'Outros',
];
List<String> optionsCataterGastrico = [
  'Nasogástrico',
  'Orogástrico',
  'Enteral',
  'Não',
];
List<String> optionsAVDI = [
  'Alerta',
  'Dor',
  'Voz',
  'Inconciente',
  'Sem alteração'
];
List<String> optionsPupilas = [
  'Isocóricas',
  'Mitióticas',
  'Midriáticas',
  'Anisocóricas',
  'D>E',
  'E>D'
];
List<String> optionsOxigenio = ['MAF', 'Catéter', 'Não'];
List<String> optionsAcessoCentralLocal = ['JE', 'JD', 'SCD', 'SCE', 'RID'];
List<String> optionsDrenoToraxLocal = ['HTD', 'HTE', 'HTD e HTE'];
List<String> optionsPrecaucoes = ['Gotículas', 'Aerossóis', 'Contato'];
List<String> optionsGestacao = ['Primigesta', 'Multigesta'];

PPModel examplePP = PPModel(
  identificacao: IdentificacaoModel(
    nome: "João Silva",
    idade: "35",
    dataNascimento: "1988-03-15",
    nomeMae: "Maria Silva",
    sexo: "M",
    formaEncaminhamento: "SIATE",
  ),
  situacao: SituacaoModel(
    origem: "Residência",
    sintomas: SintomasModel(
      horario: '12:00',
      dorToracica: true,
      deficitMotor: false,
      local: 'local',
      outros: 'outros',
    ),
    clinica: "asdasdasd",
    trauma: "Agressão",
    gestante: GestanteModel(
      bcf: "bcf",
      ig: "ig",
      perdasVW: true,
      tipoGestacao: "Primigesta",
    ),
    hipoteseDiagnostico: "Pneumonia",
    enfermeiroResponsavelTransferencia: "Maria Souza",
  ),
  breveHistorico: BreveHistoricoModel(
    historicaClinica: "Hipertensão arterial",
    alergias: 'TESTES',
    comorbidades: "Diabetes tipo 2",
    vicios: "Nenhum",
    medicamentoEmUso: "Losartana",
    historicoInternacoes: "Nenhuma",
    cirurgiaPrevia: "Cirurgia de apendicite em 2010",
    lesoes: "Nenhuma",
    alteracoesLaboratoriais: "Nenhuma",
    precaucoes: "Gotículas",
    jejum: "12 horas",
  ),
  avaliacao: AvaliacaoModel(
    dor: null,
    pa: "120/80",
    temperatura: "38.5",
    fr: "20",
    fc: "80",
    glicemia: "110",
    sp02: "98",
    ao: 4,
    rv: 3,
    rm: 2,
    avdi: "Inconciente",
    pupilas: "Midriáticas",
    intubacao: IntubacaoModel(
      horario: "12:00",
      numeroTubo: '123',
      responsavel: 'Maria Souza',
    ),
    oxigenio: OxigenioModel(tipo: 'MAF', litrosMinuto: 5.5),
    nomeMedicao: "Nenhuma",
    acesso: AcessoModel(
      central: AcessoCentral(
          profissional: 'Gabriel Lima', horario: '12:00', local: 'JE'),
      periferico: AcessoPeriferico(
          profissional: 'Gabriel Lima',
          horario: '13:00',
          local: 'periferico',
          numeroDispositivoIntravenoso: 25),
      intraosseo: AcessoIntraosseo(
          profissional: 'Gabriel Lima', horario: '14:00', local: 'no osso'),
    ),
    drenoTorax: DrenoToraxModel(
        local: 'HTD',
        numero: '2',
        horario: '12:30',
        profissional: 'Gabriel Lima'),
    cateterGastrico: null,
    cateterVesical: CateterVisicalModel(
        tamanho: 16.0, horario: '23:30', profissional: 'Gabriel Lima'),
    // pcr: null,
    ecg: "Normal",
    outrasAnotacoes: "Paciente alérgico a amoxicilina.",
  ),
  recomendacoes: RecomendacoesModel(
      encaminhamento: "Hospital do Trabalhador",
      familiarPresente: [
        FamiliarPresente(nome: 'Gabriel Lima'),
        FamiliarPresente(nome: 'Menolli'),
      ],
      pertences: Pertences(nome: 'Gabriel Lima', parentesco: 'Pai'),
      responsavelRecebimento: ResponsavelRecebimento(
          nome: 'Matheus Valeri', cpf: '48052317851', cargo: 'Médico')),
);
