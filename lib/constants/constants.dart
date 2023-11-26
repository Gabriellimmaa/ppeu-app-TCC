import 'package:flutter/cupertino.dart';
import 'package:ppeu/models/PP.model.dart';
import 'package:ppeu/models/PP/Acesso.model.dart';
import 'package:ppeu/models/PP/CateterVesical.model.dart';
import 'package:ppeu/models/PP/DrenoTorax.model.dart';
import 'package:ppeu/models/PP/Gestante.model.dart';
import 'package:ppeu/models/PP/Intubacao.model.dart';
import 'package:ppeu/models/PP/Oxigenio.model.dart';
import 'package:ppeu/models/PP/Pertences.model.dart';
import 'package:ppeu/models/PP/PupilaFotoreacao.model.dart';
import 'package:ppeu/models/PP/ResponsavelRecebimento.model.dart';
import 'package:ppeu/models/PP/Sintomas.model.dart';

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
  'Pulmonar/Respiratório',
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
  'Mióticas',
  'Midriáticas',
  'Anisocóricas'
];
List<String> optionsPupilasAnisocoricas = ['D > E', 'E > D'];
List<String> optionsPupilasFotoreacao = ['D', 'E', 'Nenhuma'];
List<String> optionsAcidenteTransito = [
  'Atropelamento',
  'Auto -> Auto',
  'Auto -> Moto',
  'Auto -> Anteparo',
  'Auto -> Caminhão',
  'Outros',
];
List<String> optionsAcessoIntraosseo = [
  'Rádio D',
  'Rádio E',
  'Tíbia D',
  'Tíbia E',
  'Úmero D',
  'Úmero E'
];
List<String> optionsOxigenio = ['MAF', 'Catéter', 'Não'];
List<String> optionsAcessoCentralLocal = [
  'JE',
  'JD',
  'SCD',
  'SCE',
  'RID',
  'RIE'
];
List<String> optionsDrenoToraxLocal = ['HTD', 'HTE', 'HTD e HTE'];
List<String> optionsPrecaucoes = ['Gotículas', 'Aerossóis', 'Contato'];
List<String> optionsGestacao = ['Primigesta', 'Multigesta'];
