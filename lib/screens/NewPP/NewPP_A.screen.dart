import 'package:ppeu/core/notifier/newPP.notifier.dart';
import 'package:ppeu/models/PP/Acesso.model.dart';
import 'package:ppeu/models/PP/CateterGastrico.model.dart';
import 'package:ppeu/models/PP/CateterVesical.model.dart';
import 'package:ppeu/models/PP/Dor.model.dart';
import 'package:ppeu/models/PP/DrenoTorax.model.dart';
import 'package:ppeu/models/PP/Intubacao.model.dart';
import 'package:ppeu/models/PP/Oxigenio.model.dart';
import 'package:ppeu/utils/validation/FormValidators.validation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ppeu/constants/constants.dart';
import 'package:ppeu/models/PP.model.dart';
import 'package:ppeu/models/PP/PCR.model.dart';
import 'package:ppeu/screens/NewPP/widgets/ModalAddMedicacao.widget.dart';
import 'package:ppeu/widgets/inputs/TimePickerTextField.widget.dart';

class NewPP_A extends StatefulWidget {
  final PPModel? data;

  const NewPP_A({Key? key, this.data}) : super(key: key);

  @override
  State<NewPP_A> createState() => _NewPP_AState();
}

class _NewPP_AState extends State<NewPP_A> {
  PPModel? data;
  late GlobalKey<FormState> _formKey;

  bool _selectedDor = false;
  bool _selectedIntubacao = false;
  String? _selectedOxigenio;
  double _oxigenioLitros = 1.0;
  bool _selectecNomeMedicacao = false;

  bool _selectedAcessoCentral = false;
  bool _selectedAcessoPeriferico = false;
  bool _selectedAcessoIntraosseo = false;

  bool _selectedDrenoTorax = false;

  String? _selectedCateterGastrico;
  bool _selectedCateterVesical = false;
  bool _selectedPCR = false;
  bool _selectedECG = false;

  double _intensidadeDor = 1.0;

  final _dorLocalController = TextEditingController();
  final _dorLocalFocusNode = FocusNode();
  final _paController = TextEditingController();
  final _temperaturaController = TextEditingController();
  final _temperaturaFocusNode = FocusNode();
  final _frController = TextEditingController();
  final _frFocusNode = FocusNode();
  final _fcController = TextEditingController();
  final _fcFocusNode = FocusNode();
  final _glicemiaController = TextEditingController();
  final _glicemiaFocusNode = FocusNode();
  final _sp02Controller = TextEditingController();
  final _sp02FocusNode = FocusNode();
  double _ao = 1.0;
  double _rv = 1.0;
  double _rm = 1.0;
  String? _avdi;
  String? _pupilas;
  double? _pupilasTamanho;

  final _intubacaoHorarioController = TextEditingController();
  final _intubacaoNumeroTuboController = TextEditingController();
  final _intubacaoResponsavelController = TextEditingController();
  final _intubacaoNumeroTuboFocusNode = FocusNode();
  final _intubacaoResponsavelFocusNode = FocusNode();

  final _nomeMedicacaoController = TextEditingController();
  final _nomeMedicacaoFocusNode = FocusNode();

  final _acessoCentralProfissionalController = TextEditingController();
  final _acessoCentralHorarioController = TextEditingController();
  final _acessoCentralProfissionalFocusNode = FocusNode();
  final _acessoCentralHorarioFocusNode = FocusNode();
  String? _selectedAcessoCentralLocal;

  final _acessoPerifericoProfissionalController = TextEditingController();
  final _acessoPerifericoHorarioController = TextEditingController();
  final _acessoPerifericoLocalController = TextEditingController();
  final _acessoPerifericoDispositivoIntravenosoController =
      TextEditingController();
  final _acessoPerifericoLocalFocusNode = FocusNode();
  final _acessoPerifericoProfissionalFocusNode = FocusNode();
  final _acessoPerifericoHorarioFocusNode = FocusNode();
  final _acessoPerifericoNumeroDispositivoIntravenosoFocusNode = FocusNode();

  final _acessoIntraosseoProfissionalController = TextEditingController();
  final _acessoIntraosseoHorarioController = TextEditingController();
  String? _acessoIntraosseoLocal;
  final _acessoIntraosseoLocalFocusNode = FocusNode();
  final _acessoIntraosseoHorarioFocusNode = FocusNode();
  final _acessoIntraosseoProfissionalFocusNode = FocusNode();

  String? _selectedDrenoToraxLocal;
  final _drenoToraxNumeroController = TextEditingController();
  final _drenoToraxHorarioController = TextEditingController();
  final _drenoToraxProfissionalController = TextEditingController();
  final _drenoToraxNumeroFocusNode = FocusNode();
  final _drenoToraxHorarioFocusNode = FocusNode();
  final _drenoToraxProfissionalFocusNode = FocusNode();

  final _cateterGastricoProfissionalController = TextEditingController();

  double _cateterVesicalTamanho = 14.0;
  final _cateterVesicalHorarioController = TextEditingController();
  final _cateterVesicalProfissionalController = TextEditingController();
  final _cateterVesicalProfissionalFocusNode = FocusNode();

  final _pcrCiclosController = TextEditingController();
  final _pcrMedicacoesController = TextEditingController();
  final _pcrMedicacoesHorariosController = TextEditingController();
  bool _selectedPCRCardioversaoDesfribilacao = false;
  double? _quantidadeCardioversaoDesfribilacao = null;
  final List<PCRMedicacao> _listPCRMedicacoes = [];

  final _ecgController = TextEditingController();
  final _ecgFocusNode = FocusNode();
  final _outrasAnotacoesController = TextEditingController();
  final _avaliacaoTraumasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    data = widget.data;
    NewPPNotifier newPPNotifier =
        Provider.of<NewPPNotifier>(context, listen: false);
    _formKey = newPPNotifier.formKeyAvaliacao;

    if (data != null) {
      bool hasDor = data?.avaliacao.dor != null;
      bool hasIntubacao = data!.avaliacao.intubacao != null;
      bool hasOxigenio = data!.avaliacao.oxigenio != null;
      bool hasEspecieMedicacao = data!.avaliacao.nomeMedicacao != null;
      bool hasDrenoTorax = data!.avaliacao.drenoTorax != null;
      bool hasCateterVesical = data!.avaliacao.cateterVesical != null;
      bool hasPCR = data!.avaliacao.pcr != null;
      bool hasECG = data!.avaliacao.ecg != null;
      bool hasAcessoCentral = data!.avaliacao.acesso.central != null;
      bool hasAcessoPeriferico = data!.avaliacao.acesso.periferico != null;
      bool hasAcessoIntraosseo = data!.avaliacao.acesso.intraosseo != null;

      _paController.text = data!.avaliacao.pa;
      _temperaturaController.text = data!.avaliacao.temperatura;
      _frController.text = data!.avaliacao.fr;
      _fcController.text = data!.avaliacao.fc;
      _glicemiaController.text = data!.avaliacao.glicemia;
      _sp02Controller.text = data!.avaliacao.sp02;
      _ao = data!.avaliacao.ao;
      _rv = data!.avaliacao.rv;
      _rm = data!.avaliacao.rm;
      _avdi = data!.avaliacao.avdi;
      _pupilas = data!.avaliacao.pupilas;
      _pupilasTamanho = data!.avaliacao.pupilasTamanho;

      if (hasAcessoCentral) {
        _selectedAcessoCentral = hasAcessoCentral ? true : false;
        _selectedAcessoCentralLocal = data!.avaliacao.acesso.central!.local;
        _acessoCentralProfissionalController.text =
            data!.avaliacao.acesso.central!.profissional;
        _acessoCentralHorarioController.text =
            data!.avaliacao.acesso.central!.horario;
      }
      if (hasAcessoPeriferico) {
        _acessoPerifericoDispositivoIntravenosoController.text = data!
            .avaliacao.acesso.periferico!.numeroDispositivoIntravenoso
            .toString();
        _selectedAcessoPeriferico = hasAcessoPeriferico ? true : false;
        _acessoPerifericoLocalController.text =
            data!.avaliacao.acesso.periferico!.local;
        _acessoPerifericoProfissionalController.text =
            data!.avaliacao.acesso.periferico!.profissional;
        _acessoPerifericoHorarioController.text =
            data!.avaliacao.acesso.periferico!.horario;
      }
      if (hasAcessoIntraosseo) {
        _selectedAcessoIntraosseo = hasAcessoIntraosseo ? true : false;
        _acessoIntraosseoLocal = data!.avaliacao.acesso.intraosseo!.local;
        _acessoIntraosseoProfissionalController.text =
            data!.avaliacao.acesso.intraosseo!.profissional;
        _acessoIntraosseoHorarioController.text =
            data!.avaliacao.acesso.intraosseo!.horario;
      }

      if (hasIntubacao) {
        _intubacaoHorarioController.text = data!.avaliacao.intubacao!.horario;
        _intubacaoNumeroTuboController.text =
            data!.avaliacao.intubacao!.numeroTubo;
        _intubacaoResponsavelController.text =
            data!.avaliacao.intubacao!.responsavel;
      }

      if (hasOxigenio) {
        _oxigenioLitros = data!.avaliacao.oxigenio!.litrosMinuto;
      }

      _nomeMedicacaoController.text = data!.avaliacao.nomeMedicacao ?? '';

      if (hasDrenoTorax) {
        _selectedDrenoToraxLocal = data!.avaliacao.drenoTorax!.local;
        _drenoToraxNumeroController.text = data!.avaliacao.drenoTorax!.numero;
        _drenoToraxHorarioController.text = data!.avaliacao.drenoTorax!.horario;
        _drenoToraxProfissionalController.text =
            data!.avaliacao.drenoTorax!.profissional;
      }

      _selectedCateterGastrico = data?.avaliacao.cateterGastrico != null
          ? data?.avaliacao.cateterGastrico!.tipo
          : 'Não';

      _cateterGastricoProfissionalController.text =
          data?.avaliacao.cateterGastrico?.profissional ?? '';

      if (hasCateterVesical) {
        _cateterVesicalTamanho = data!.avaliacao.cateterVesical!.tamanho;
        _cateterVesicalHorarioController.text =
            data!.avaliacao.cateterVesical!.horario;
        _cateterVesicalProfissionalController.text =
            data!.avaliacao.cateterVesical!.profissional;
      }

      if (hasPCR) {
        _pcrCiclosController.text = data!.avaliacao.pcr!.ciclos;
        _listPCRMedicacoes.addAll(data!.avaliacao.pcr!.medicacoes);
        _selectedPCRCardioversaoDesfribilacao =
            data!.avaliacao.pcr!.cardioversaoOuDesfribilacao;
        if (_selectedPCRCardioversaoDesfribilacao == true) {
          _quantidadeCardioversaoDesfribilacao =
              data!.avaliacao.pcr!.quantidadeCardioversaoDesfribilacao;
        }
      }

      if (hasDor) {
        _dorLocalController.text = data!.avaliacao.dor!.local;
        _intensidadeDor = data!.avaliacao.dor!.intensidade;
      }

      _ecgController.text = data!.avaliacao.ecg ?? '';
      _avaliacaoTraumasController.text = data!.avaliacao.avaliacaoTraumas;
      _outrasAnotacoesController.text = data!.avaliacao.outrasAnotacoes;

      _selectedDor = hasDor ? true : false;
      _selectedIntubacao = hasIntubacao ? true : false;
      _selectedDrenoTorax = hasDrenoTorax ? true : false;
      _selectedPCR = hasPCR ? true : false;
      _selectedECG = hasECG ? true : false;
      _selectedCateterVesical = hasCateterVesical ? true : false;
      _selectecNomeMedicacao = hasEspecieMedicacao ? true : false;
    }
  }

  @override
  void dispose() {
    _fcController.dispose();
    _glicemiaController.dispose();
    _sp02Controller.dispose();
    _acessoCentralProfissionalController.dispose();
    _acessoCentralHorarioController.dispose();
    _acessoPerifericoLocalController.dispose();
    _acessoPerifericoProfissionalController.dispose();
    _acessoPerifericoHorarioController.dispose();
    _acessoIntraosseoProfissionalController.dispose();
    _acessoIntraosseoHorarioController.dispose();
    _intubacaoHorarioController.dispose();
    _intubacaoNumeroTuboController.dispose();
    _intubacaoResponsavelController.dispose();
    _nomeMedicacaoController.dispose();
    _drenoToraxNumeroController.dispose();
    _drenoToraxHorarioController.dispose();
    _drenoToraxProfissionalController.dispose();
    _cateterGastricoProfissionalController.dispose();
    _cateterVesicalHorarioController.dispose();
    _cateterVesicalProfissionalController.dispose();
    _pcrCiclosController.dispose();
    _pcrMedicacoesController.dispose();
    _pcrMedicacoesHorariosController.dispose();
    _dorLocalController.dispose();
    _ecgController.dispose();
    _outrasAnotacoesController.dispose();

    _cateterVesicalProfissionalFocusNode.dispose();
    _drenoToraxProfissionalFocusNode.dispose();
    _drenoToraxHorarioFocusNode.dispose();
    _drenoToraxNumeroFocusNode.dispose();
    _nomeMedicacaoFocusNode.dispose();
    _intubacaoResponsavelFocusNode.dispose();
    _intubacaoNumeroTuboFocusNode.dispose();
    _acessoIntraosseoHorarioFocusNode.dispose();
    _acessoIntraosseoProfissionalFocusNode.dispose();
    _acessoIntraosseoLocalFocusNode.dispose();
    _acessoPerifericoHorarioFocusNode.dispose();
    _acessoPerifericoProfissionalFocusNode.dispose();
    _acessoPerifericoLocalFocusNode.dispose();
    _acessoCentralHorarioFocusNode.dispose();
    _acessoCentralProfissionalFocusNode.dispose();
    _ecgFocusNode.dispose();
    _dorLocalFocusNode.dispose();
    _temperaturaFocusNode.dispose();
    _frFocusNode.dispose();
    _fcFocusNode.dispose();
    _glicemiaFocusNode.dispose();
    _sp02FocusNode.dispose();
    super.dispose();
  }

  void checkValidFields() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    NewPPNotifier newPPNotifier =
        Provider.of<NewPPNotifier>(context, listen: false);

    void updateFormData() {
      bool hasDor = _selectedDor == true;
      bool hasIntubacao = _selectedIntubacao == true;
      bool hasOxigenio = _selectedOxigenio != null;
      bool hasDrenoTorax = _selectedDrenoTorax == true;
      bool hasCateterVesical = _selectedCateterVesical == true;
      bool hasPCR = _selectedPCR == true;
      bool hasECG = _selectedECG == true;
      bool hasAcessoCentral = _selectedAcessoCentral == true;
      bool hasAcessoPeriferico = _selectedAcessoPeriferico == true;
      bool hasAcessoIntraosseo = _selectedAcessoIntraosseo == true;

      newPPNotifier.avaliacao = AvaliacaoModel(
        acesso: AcessoModel(
          central: hasAcessoCentral
              ? AcessoCentral(
                  local: _selectedAcessoCentralLocal ?? '',
                  horario: _acessoCentralHorarioController.text,
                  profissional: _acessoCentralProfissionalController.text,
                )
              : null,
          intraosseo: hasAcessoIntraosseo
              ? AcessoIntraosseo(
                  horario: _acessoIntraosseoHorarioController.text,
                  local: _acessoIntraosseoLocal ?? '',
                  profissional: _acessoIntraosseoProfissionalController.text,
                )
              : null,
          periferico: hasAcessoPeriferico
              ? AcessoPeriferico(
                  horario: _acessoPerifericoHorarioController.text,
                  local: _acessoPerifericoLocalController.text,
                  profissional: _acessoPerifericoProfissionalController.text,
                  numeroDispositivoIntravenoso: int.parse(
                      _acessoPerifericoDispositivoIntravenosoController.text))
              : null,
        ),
        cateterGastrico: _selectedCateterGastrico == 'Não'
            ? null
            : CateterGastricoModel(
                profissional: _cateterGastricoProfissionalController.text,
                tipo: _selectedCateterGastrico ?? '',
              ),
        cateterVesical: hasCateterVesical
            ? CateterVesicalModel(
                horario: _cateterVesicalHorarioController.text,
                profissional: _cateterVesicalProfissionalController.text,
                tamanho: _cateterVesicalTamanho,
              )
            : null,
        dor: hasDor
            ? DorModel(
                intensidade: _intensidadeDor,
                local: _dorLocalController.text,
              )
            : null,
        drenoTorax: hasDrenoTorax
            ? DrenoToraxModel(
                horario: _drenoToraxHorarioController.text,
                numero: _drenoToraxNumeroController.text,
                profissional: _drenoToraxProfissionalController.text,
                local: _selectedDrenoToraxLocal ?? '',
              )
            : null,
        ecg: hasECG ? _ecgController.text : null,
        intubacao: hasIntubacao
            ? IntubacaoModel(
                horario: _intubacaoHorarioController.text,
                numeroTubo: _intubacaoNumeroTuboController.text,
                responsavel: _intubacaoResponsavelController.text,
              )
            : null,
        glicemia: _glicemiaController.text,
        pcr: hasPCR
            ? PCRModel(
                ciclos: _pcrCiclosController.text,
                medicacoes: _listPCRMedicacoes,
                cardioversaoOuDesfribilacao:
                    _selectedPCRCardioversaoDesfribilacao,
                quantidadeCardioversaoDesfribilacao:
                    _quantidadeCardioversaoDesfribilacao,
              )
            : null,
        outrasAnotacoes: _outrasAnotacoesController.text,
        avaliacaoTraumas: _avaliacaoTraumasController.text,
        fc: _fcController.text,
        fr: _frController.text,
        sp02: _sp02Controller.text,
        temperatura: _temperaturaController.text,
        pa: _paController.text,
        rm: _rm,
        rv: _rv,
        ao: _ao,
        avdi: _avdi ?? '',
        pupilas: _pupilas ?? '',
        pupilasTamanho: _pupilasTamanho,
        nomeMedicacao: _nomeMedicacaoController.text == ''
            ? null
            : _nomeMedicacaoController.text,
        oxigenio: hasOxigenio
            ? OxigenioModel(
                litrosMinuto: _oxigenioLitros,
                tipo: _selectedOxigenio ?? '',
              )
            : null,
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: const [
                  Text('Avaliação',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                        'ECG, últimos SSVV, achados do exame físico, breve avaliação do estado geral, possível diagnosticom, quais ação e tratamento até agora',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              )),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'SINAIS VITAIS',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(children: [
                      spacingRow,
                      Expanded(
                        child: Text('Dor:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Sim'),
                          value: true,
                          groupValue: _selectedDor,
                          onChanged: (value) {
                            if (data != null) {
                              return;
                            }
                            setState(() {
                              _selectedDor = value as bool;
                            });
                            _dorLocalFocusNode.requestFocus();
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Não'),
                          value: false,
                          groupValue: _selectedDor,
                          onChanged: (value) {
                            if (data != null) {
                              return;
                            }
                            setState(() {
                              _selectedDor = value as bool;
                            });
                          },
                        ),
                      ),
                    ]),
                  ),
                  if (_selectedDor == true) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: [
                        TextFormField(
                          controller: _dorLocalController,
                          focusNode: _dorLocalFocusNode,
                          readOnly: data != null,
                          decoration: InputDecoration(
                            labelText: 'Local',
                          ),
                          validator: (value) => FormValidators.required(value,
                              condition: _selectedDor == true),
                          onChanged: (_) => checkValidFields(),
                        ),
                        spacingRow,
                        Text('Intensidade da dor:',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        Slider(
                          value: _intensidadeDor,
                          min: 1.0,
                          max: 10.0,
                          divisions: 9,
                          label: _intensidadeDor.toString(),
                          onChanged: (double value) {
                            setState(() {
                              _intensidadeDor = value;
                            });
                          },
                        ),
                      ]),
                    ),
                    spacingRow,
                  ],
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: data != null,
                                controller: _paController,
                                decoration: InputDecoration(
                                  labelText: 'PA',
                                ),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_temperaturaFocusNode),
                                onSaved: (value) {
                                  updateFormData();
                                },
                                validator: FormValidators.required,
                                onChanged: (_) => checkValidFields(),
                              ),
                            ),
                            spacingColumn,
                            Expanded(
                              child: TextFormField(
                                readOnly: data != null,
                                controller: _temperaturaController,
                                focusNode: _temperaturaFocusNode,
                                decoration: InputDecoration(
                                  labelText: 'Temperatura',
                                ),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_frFocusNode),
                                validator: FormValidators.required,
                                onChanged: (_) => checkValidFields(),
                              ),
                            ),
                          ],
                        ),
                        spacingRow,
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: data != null,
                                controller: _frController,
                                focusNode: _frFocusNode,
                                decoration: InputDecoration(
                                  labelText: 'FR',
                                ),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_fcFocusNode),
                                validator: FormValidators.required,
                                onChanged: (_) => checkValidFields(),
                              ),
                            ),
                            spacingColumn,
                            Expanded(
                              child: TextFormField(
                                readOnly: data != null,
                                controller: _fcController,
                                focusNode: _fcFocusNode,
                                decoration: InputDecoration(
                                  labelText: 'FC',
                                ),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_glicemiaFocusNode),
                                validator: FormValidators.required,
                                onChanged: (_) => checkValidFields(),
                              ),
                            ),
                          ],
                        ),
                        spacingRow,
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: data != null,
                                controller: _glicemiaController,
                                focusNode: _glicemiaFocusNode,
                                decoration: InputDecoration(
                                  labelText: 'Glicemia',
                                ),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_sp02FocusNode),
                                validator: FormValidators.required,
                                onChanged: (_) => checkValidFields(),
                              ),
                            ),
                            spacingColumn,
                            Expanded(
                              child: TextFormField(
                                readOnly: data != null,
                                controller: _sp02Controller,
                                focusNode: _sp02FocusNode,
                                decoration: InputDecoration(
                                  labelText: 'SP02',
                                ),
                                validator: FormValidators.required,
                                onChanged: (_) => checkValidFields(),
                              ),
                            ),
                          ],
                        ),
                        spacingRow
                      ],
                    ),
                  ),
                  Text(
                    'PADRÃO NEUROLÓGICO',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      Row(
                        children: [
                          Expanded(
                            child: Column(children: [
                              Text('AO'),
                              Slider(
                                  value: _ao,
                                  min: 1.0,
                                  max: 4.0,
                                  divisions: 3,
                                  label: _ao.toInt().toString(),
                                  onChanged: (value) {
                                    if (data != null) {
                                      return;
                                    }
                                    setState(() {
                                      _ao = value;
                                    });
                                  })
                            ]),
                          ),
                          spacingColumn,
                          Expanded(
                            child: Column(children: [
                              Text('RV'),
                              Slider(
                                  value: _rv,
                                  min: 1.0,
                                  max: 5.0,
                                  divisions: 4,
                                  label: _rv.toInt().toString(),
                                  onChanged: (value) {
                                    if (data != null) {
                                      return;
                                    }
                                    setState(() {
                                      _rv = value;
                                    });
                                  })
                            ]),
                          ),
                        ],
                      ),
                      spacingRow,
                      Row(
                        children: [
                          Expanded(
                            child: Column(children: [
                              Text('RM'),
                              Slider(
                                  value: _rm,
                                  min: 1.0,
                                  max: 6.0,
                                  divisions: 5,
                                  label: _rm.toInt().toString(),
                                  onChanged: (value) {
                                    if (data != null) {
                                      return;
                                    }
                                    setState(() {
                                      _rm = value;
                                    });
                                  })
                            ]),
                          ),
                          spacingColumn,
                          Expanded(
                            child: Text(
                              'Resultado: ${_rm.toInt() + _rv.toInt() + _ao.toInt()}/15',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      spacingRow,
                      DropdownButtonFormField(
                        value: _avdi,
                        decoration: InputDecoration(labelText: 'AVDI'),
                        items: optionsAVDI
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e,
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                ))
                            .toList(),
                        onChanged: data != null
                            ? null
                            : (value) {
                                setState(() {
                                  checkValidFields();
                                  _avdi = value as String;
                                });
                              },
                        validator: FormValidators.required,
                      ),
                      spacingRow,
                      DropdownButtonFormField(
                        value: _pupilas,
                        decoration: InputDecoration(labelText: 'Pupilas'),
                        items: optionsPupilas
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e,
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                ))
                            .toList(),
                        onChanged: data != null
                            ? null
                            : (value) {
                                setState(() {
                                  checkValidFields();
                                  _pupilas = value as String;
                                });
                              },
                        validator: FormValidators.required,
                      ),
                      spacingRow,
                      if (_pupilas == 'Fotorreagente') ...[
                        spacingRow,
                        Column(children: [
                          Text('Tamanho das pupilas em mm'),
                          Slider(
                              value: _pupilasTamanho ?? 1.0,
                              min: 1.0,
                              max: 9.0,
                              divisions: 8,
                              label: _pupilasTamanho?.toInt().toString() ?? '1',
                              onChanged: (value) {
                                if (data != null) {
                                  return;
                                }
                                setState(() {
                                  _pupilasTamanho = value;
                                });
                              })
                        ]),
                      ],
                    ]),
                  ),
                  Text(
                    'INTUBAÇÃO',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      Row(children: [
                        spacingRow,
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('Sim'),
                            value: true,
                            groupValue: _selectedIntubacao,
                            onChanged: (value) {
                              if (data != null) {
                                return;
                              }
                              setState(() {
                                _selectedIntubacao = value as bool;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('Não'),
                            value: false,
                            groupValue: _selectedIntubacao,
                            onChanged: (value) {
                              if (data != null) {
                                return;
                              }
                              setState(() {
                                _selectedIntubacao = value as bool;
                              });
                            },
                          ),
                        ),
                      ]),
                      if (_selectedIntubacao == true)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(children: [
                            Row(
                              children: [
                                Expanded(
                                    // child: TextFormField(
                                    //   readOnly: data != null,
                                    //   controller: _intubacaoHorarioController,
                                    //   decoration: InputDecoration(
                                    //     labelText: 'Horário',
                                    //   ),
                                    //   keyboardType: TextInputType.datetime,
                                    // ),
                                    child: TimePickerTextField(
                                  labelText: 'Horário',
                                  controller: _intubacaoHorarioController,
                                  readOnly: data != null,
                                  onChanged: (value) {
                                    checkValidFields();
                                    FocusScope.of(context).requestFocus(
                                        _intubacaoNumeroTuboFocusNode);
                                  },
                                  validator: (value) => FormValidators.required(
                                      value,
                                      condition: _selectedIntubacao),
                                )),
                                spacingColumn,
                                Expanded(
                                  child: TextFormField(
                                    readOnly: data != null,
                                    controller: _intubacaoNumeroTuboController,
                                    focusNode: _intubacaoNumeroTuboFocusNode,
                                    decoration: InputDecoration(
                                      labelText: 'Nº do tubo',
                                    ),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) =>
                                        FocusScope.of(context).requestFocus(
                                            _intubacaoResponsavelFocusNode),
                                    validator: (value) =>
                                        FormValidators.required(value,
                                            condition: _selectedIntubacao),
                                    onChanged: (_) => checkValidFields(),
                                  ),
                                )
                              ],
                            ),
                            spacingRow,
                            TextFormField(
                              readOnly: data != null,
                              controller: _intubacaoResponsavelController,
                              focusNode: _intubacaoResponsavelFocusNode,
                              decoration: InputDecoration(
                                labelText: 'Responsável',
                              ),
                              validator: (value) => FormValidators.required(
                                  value,
                                  condition: _selectedIntubacao),
                              onChanged: (_) => checkValidFields(),
                            ),
                            spacingRow,
                          ]),
                        ),
                    ]),
                  ),
                  Text(
                    'OXIGÊNIO',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      DropdownButtonFormField(
                          value: _selectedOxigenio,
                          decoration: InputDecoration(labelText: 'Oxigênio'),
                          items: optionsOxigenio
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e,
                                        style: TextStyle(
                                          color: Colors.black,
                                        )),
                                  ))
                              .toList(),
                          onChanged: data != null
                              ? null
                              : (value) {
                                  setState(() {
                                    if (value == 'MAF') {
                                      _oxigenioLitros = 7.0;
                                    }
                                    if (value == 'Catéter') {
                                      _oxigenioLitros = 1.0;
                                    }

                                    _selectedOxigenio =
                                        value == 'Não' ? null : value as String;
                                    checkValidFields();
                                  });
                                },
                          validator: FormValidators.required),
                      spacingRow,
                      if (_selectedOxigenio != 'Não' &&
                          _selectedOxigenio != null)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(children: [
                            Text(
                              'Litros por minutos (L/M)',
                              style: TextStyle(fontSize: 16),
                            ),
                            Slider(
                              value: _oxigenioLitros,
                              min: _selectedOxigenio == 'MAF' ? 7.0 : 1.0,
                              max: _selectedOxigenio == 'MAF' ? 15.0 : 6.0,
                              divisions:
                                  ((_selectedOxigenio == 'MAF' ? 15.0 : 6.0) -
                                          (_selectedOxigenio == 'MAF'
                                              ? 7.0
                                              : 1.0)) ~/
                                      0.5,
                              label: _oxigenioLitros.toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _oxigenioLitros = value;
                                });
                              },
                            ),
                            spacingRow,
                          ]),
                        ),
                    ]),
                  ),
                  Text(
                    'MEDICAÇÕES',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      Row(children: [
                        spacingRow,
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('Sim'),
                            value: true,
                            groupValue: _selectecNomeMedicacao,
                            onChanged: (value) {
                              if (data != null) {
                                return;
                              }
                              setState(() {
                                _selectecNomeMedicacao = value as bool;
                                _nomeMedicacaoFocusNode.requestFocus();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('Não'),
                            value: false,
                            groupValue: _selectecNomeMedicacao,
                            onChanged: (value) {
                              if (data != null) {
                                return;
                              }
                              setState(() {
                                _selectecNomeMedicacao = value as bool;
                              });
                            },
                          ),
                        ),
                      ]),
                      if (_selectecNomeMedicacao == true)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(children: [
                            TextFormField(
                              readOnly: data != null,
                              controller: _nomeMedicacaoController,
                              focusNode: _nomeMedicacaoFocusNode,
                              decoration: InputDecoration(
                                labelText: 'Nome da medicação',
                              ),
                              validator: (value) => FormValidators.required(
                                  value,
                                  condition: _selectecNomeMedicacao),
                              onChanged: (_) => checkValidFields(),
                            ),
                            spacingRow,
                          ]),
                        ),
                    ]),
                  ),
                  Text(
                    'ACESSO',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(children: [
                      spacingRow,
                      Expanded(
                        child: Text('Central:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Sim'),
                          value: true,
                          groupValue: _selectedAcessoCentral,
                          onChanged: (value) {
                            if (data != null) {
                              return;
                            }
                            setState(() {
                              _selectedAcessoCentral = value as bool;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Não'),
                          value: false,
                          groupValue: _selectedAcessoCentral,
                          onChanged: (value) {
                            if (data != null) {
                              return;
                            }
                            setState(() {
                              _selectedAcessoCentral = value as bool;
                            });
                          },
                        ),
                      ),
                    ]),
                  ),
                  if (_selectedAcessoCentral == true)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: [
                        DropdownButtonFormField(
                          value: _selectedAcessoCentralLocal,
                          decoration: InputDecoration(labelText: 'Local'),
                          items: optionsAcessoCentralLocal
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e,
                                        style: TextStyle(
                                          color: Colors.black,
                                        )),
                                  ))
                              .toList(),
                          onChanged: data != null
                              ? null
                              : (value) {
                                  setState(() {
                                    checkValidFields();
                                    _selectedAcessoCentralLocal =
                                        value as String?;
                                    FocusScope.of(context).requestFocus(
                                        _acessoCentralProfissionalFocusNode);
                                  });
                                },
                          validator: (value) => FormValidators.required(value,
                              condition: _selectedAcessoCentral),
                        ),
                        spacingRow,
                        TextFormField(
                          readOnly: data != null,
                          controller: _acessoCentralProfissionalController,
                          focusNode: _acessoCentralProfissionalFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Profissional',
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_acessoCentralHorarioFocusNode),
                          validator: (value) => FormValidators.required(value,
                              condition: _selectedAcessoCentral),
                          onChanged: (_) => checkValidFields(),
                        ),
                        spacingRow,
                        TimePickerTextField(
                          readOnly: data != null,
                          controller: _acessoCentralHorarioController,
                          focusNode: _acessoCentralHorarioFocusNode,
                          labelText: 'Horário',
                          validator: (value) => FormValidators.required(value,
                              condition: _selectedAcessoCentral),
                          onChanged: (_) => checkValidFields(),
                        ),
                      ]),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(children: [
                      spacingRow,
                      Expanded(
                        child: Text('Periférico:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Sim'),
                          value: true,
                          groupValue: _selectedAcessoPeriferico,
                          onChanged: (value) {
                            if (data != null) {
                              return;
                            }
                            setState(() {
                              _selectedAcessoPeriferico = value as bool;
                              _acessoPerifericoLocalFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Não'),
                          value: false,
                          groupValue: _selectedAcessoPeriferico,
                          onChanged: (value) {
                            if (data != null) {
                              return;
                            }
                            setState(() {
                              _selectedAcessoPeriferico = value as bool;
                            });
                          },
                        ),
                      ),
                    ]),
                  ),
                  if (_selectedAcessoPeriferico == true)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: [
                        TextFormField(
                          readOnly: data != null,
                          controller: _acessoPerifericoLocalController,
                          focusNode: _acessoPerifericoLocalFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Local',
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(
                                  _acessoPerifericoProfissionalFocusNode),
                          validator: (value) => FormValidators.required(value,
                              condition: _selectedAcessoPeriferico),
                          onChanged: (_) => checkValidFields(),
                        ),
                        spacingRow,
                        TextFormField(
                          readOnly: data != null,
                          controller: _acessoPerifericoProfissionalController,
                          focusNode: _acessoPerifericoProfissionalFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Profissional',
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_acessoPerifericoHorarioFocusNode),
                          validator: (value) => FormValidators.required(value,
                              condition: _selectedAcessoPeriferico),
                          onChanged: (_) => checkValidFields(),
                        ),
                        spacingRow,
                        TimePickerTextField(
                          controller: _acessoPerifericoHorarioController,
                          focusNode: _acessoPerifericoHorarioFocusNode,
                          readOnly: data != null,
                          labelText: 'Horário',
                          validator: FormValidators.required,
                          onChanged: (_) => checkValidFields(),
                        ),
                        spacingRow,
                        TextFormField(
                          readOnly: data != null,
                          controller:
                              _acessoPerifericoDispositivoIntravenosoController,
                          focusNode:
                              _acessoPerifericoNumeroDispositivoIntravenosoFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Dispositivo intravenoso nº',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) => FormValidators.required(value,
                              condition: _selectedAcessoPeriferico),
                          onChanged: (_) => checkValidFields(),
                        ),
                      ]),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(children: [
                      spacingRow,
                      Expanded(
                        child: Text('Intra-ósseo:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Sim'),
                          value: true,
                          groupValue: _selectedAcessoIntraosseo,
                          onChanged: (value) {
                            if (data != null) {
                              return;
                            }
                            setState(() {
                              _selectedAcessoIntraosseo = value as bool;
                              _acessoIntraosseoLocalFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Não'),
                          value: false,
                          groupValue: _selectedAcessoIntraosseo,
                          onChanged: (value) {
                            if (data != null) {
                              return;
                            }
                            setState(() {
                              _selectedAcessoIntraosseo = value as bool;
                            });
                          },
                        ),
                      ),
                    ]),
                  ),
                  if (_selectedAcessoIntraosseo == true)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: [
                        DropdownButtonFormField(
                          value: _acessoIntraosseoLocal,
                          decoration: InputDecoration(labelText: 'Local'),
                          items: optionsAcessoIntraosseo.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e,
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                            );
                          }).toList(),
                          onSaved: (value) {
                            FocusScope.of(context).requestFocus(
                                _acessoIntraosseoProfissionalFocusNode);
                          },
                          onChanged: data != null
                              ? null
                              : (value) {
                                  setState(() {
                                    checkValidFields();
                                    _acessoIntraosseoLocal = value as String;
                                  });
                                },
                          validator: (value) => FormValidators.required(value,
                              condition: _selectedAcessoIntraosseo),
                        ),
                        spacingRow,
                        TextFormField(
                          readOnly: data != null,
                          controller: _acessoIntraosseoProfissionalController,
                          focusNode: _acessoIntraosseoProfissionalFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Profissional',
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_acessoIntraosseoHorarioFocusNode),
                          validator: (value) => FormValidators.required(value,
                              condition: _selectedAcessoIntraosseo),
                          onChanged: (_) => checkValidFields(),
                        ),
                        spacingRow,
                        TimePickerTextField(
                          readOnly: data != null,
                          controller: _acessoIntraosseoHorarioController,
                          focusNode: _acessoIntraosseoHorarioFocusNode,
                          labelText: 'Horário',
                          validator: (value) => FormValidators.required(value,
                              condition: _selectedAcessoIntraosseo),
                          onChanged: (_) => checkValidFields(),
                        ),
                      ]),
                    ),
                  spacingRow,
                  Text(
                    'DRENO DE TÓRAX',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(children: [
                      spacingRow,
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Sim'),
                          value: true,
                          groupValue: _selectedDrenoTorax,
                          onChanged: (value) {
                            if (data != null) {
                              return;
                            }
                            setState(() {
                              _selectedDrenoTorax = value as bool;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Não'),
                          value: false,
                          groupValue: _selectedDrenoTorax,
                          onChanged: (value) {
                            if (data != null) {
                              return;
                            }
                            setState(() {
                              _selectedDrenoTorax = value as bool;
                            });
                          },
                        ),
                      ),
                    ]),
                  ),
                  if (_selectedDrenoTorax == true)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: [
                        DropdownButtonFormField(
                          value: _selectedDrenoToraxLocal,
                          decoration: InputDecoration(labelText: 'Local'),
                          items: optionsDrenoToraxLocal
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )))
                              .toList(),
                          onChanged: data != null
                              ? null
                              : (value) {
                                  setState(() {
                                    checkValidFields();
                                    _selectedDrenoToraxLocal = value as String?;
                                  });
                                  FocusScope.of(context)
                                      .requestFocus(_drenoToraxNumeroFocusNode);
                                },
                          validator: (value) => FormValidators.required(value,
                              condition: _selectedDrenoTorax),
                        ),
                        spacingRow,
                        Row(children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: data != null,
                              controller: _drenoToraxNumeroController,
                              focusNode: _drenoToraxNumeroFocusNode,
                              decoration: InputDecoration(
                                labelText: 'Nº',
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) => FocusScope.of(context)
                                  .requestFocus(_drenoToraxHorarioFocusNode),
                              validator: (value) => FormValidators.required(
                                  value,
                                  condition: _selectedDrenoTorax),
                              onChanged: (_) => checkValidFields(),
                            ),
                          ),
                          spacingColumn,
                          Expanded(
                            //     child: TextFormField(
                            //   readOnly: data != null,
                            //   controller: _drenoToraxHorarioController,
                            //   focusNode: _drenoToraxHorarioFocusNode,
                            //   decoration: InputDecoration(
                            //     labelText: 'Horário',
                            //   ),
                            //   textInputAction: TextInputAction.next,
                            //   onFieldSubmitted: (_) => FocusScope.of(context)
                            //       .requestFocus(_drenoToraxProfissionalFocusNode),
                            // )
                            child: TimePickerTextField(
                              labelText: 'Horário',
                              controller: _drenoToraxHorarioController,
                              focusNode: _drenoToraxHorarioFocusNode,
                              onChanged: (_) {
                                checkValidFields();
                                FocusScope.of(context).requestFocus(
                                    _drenoToraxProfissionalFocusNode);
                              },
                              validator: (value) => FormValidators.required(
                                  value,
                                  condition: _selectedDrenoTorax),
                            ),
                          )
                        ]),
                        spacingRow,
                        TextFormField(
                          readOnly: data != null,
                          controller: _drenoToraxProfissionalController,
                          focusNode: _drenoToraxProfissionalFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Profissional',
                          ),
                          validator: (value) => FormValidators.required(value,
                              condition: _selectedDrenoTorax),
                          onChanged: (_) => checkValidFields(),
                        ),
                        spacingRow,
                      ]),
                    ),
                  Text(
                    'CATÉTER GÁSTRICO',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          spacingRow,
                          DropdownButtonFormField(
                            value: _selectedCateterGastrico,
                            decoration:
                                InputDecoration(labelText: 'Catéter gástrico'),
                            items: optionsCataterGastrico
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e,
                                          style: TextStyle(
                                            color: Colors.black,
                                          )),
                                    ))
                                .toList(),
                            onChanged: data != null
                                ? null
                                : (value) {
                                    if (data != null) {
                                      return;
                                    }
                                    setState(() {
                                      checkValidFields();
                                      _selectedCateterGastrico =
                                          value as String?;
                                    });
                                  },
                            validator: FormValidators.required,
                          ),
                          spacingRow,
                          if (_selectedCateterGastrico != 'Não' &&
                              _selectedCateterGastrico != null) ...[
                            TextFormField(
                              readOnly: data != null,
                              controller:
                                  _cateterGastricoProfissionalController,
                              decoration: InputDecoration(
                                labelText: 'Profissional',
                              ),
                              validator: (value) => FormValidators.required(
                                value,
                                condition: _selectedCateterGastrico != 'Não' &&
                                    _selectedCateterGastrico != null,
                              ),
                              onChanged: (_) => checkValidFields(),
                            ),
                            spacingRow,
                          ]
                        ],
                      )),
                  Text(
                    'CATÉTER VESICAL',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      Row(children: [
                        spacingRow,
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('Sim'),
                            value: true,
                            groupValue: _selectedCateterVesical,
                            onChanged: (value) {
                              if (data != null) {
                                return;
                              }
                              setState(() {
                                _selectedCateterVesical = value as bool;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('Não'),
                            value: false,
                            groupValue: _selectedCateterVesical,
                            onChanged: (value) {
                              if (data != null) {
                                return;
                              }
                              setState(() {
                                _selectedCateterVesical = value as bool;
                              });
                            },
                          ),
                        ),
                      ]),
                      if (_selectedCateterVesical == true) ...[
                        Text(
                          'Tamanho',
                          style: TextStyle(fontSize: 16),
                        ),
                        Slider(
                          value: _cateterVesicalTamanho,
                          min: 14.0,
                          max: 24.0,
                          divisions: (24.0 - 14.0) ~/ 0.5,
                          label: _cateterVesicalTamanho.toString(),
                          onChanged: (double value) {
                            if (data != null) {
                              return;
                            }

                            setState(() {
                              _cateterVesicalTamanho = value;
                            });
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TimePickerTextField(
                              readOnly: data != null,
                              controller: _cateterVesicalHorarioController,
                              labelText: 'Horário',
                              onChanged: (_) {
                                checkValidFields();
                                FocusScope.of(context).requestFocus(
                                    _cateterVesicalProfissionalFocusNode);
                              },
                              validator: (value) => FormValidators.required(
                                value,
                                condition: _selectedCateterVesical,
                              ),
                            ))
                          ],
                        ),
                        spacingRow,
                        TextFormField(
                          readOnly: data != null,
                          controller: _cateterVesicalProfissionalController,
                          focusNode: _cateterVesicalProfissionalFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Profissional',
                          ),
                          validator: (value) => FormValidators.required(
                            value,
                            condition: _selectedCateterVesical,
                          ),
                          onChanged: (_) => checkValidFields(),
                        ),
                        spacingRow,
                      ]
                    ]),
                  ),
                  Text(
                    'PCR',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      Row(children: [
                        spacingRow,
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('Sim'),
                            value: true,
                            groupValue: _selectedPCR,
                            onChanged: (value) {
                              if (data != null) {
                                return;
                              }
                              setState(() {
                                _selectedPCR = value as bool;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('Não'),
                            value: false,
                            groupValue: _selectedPCR,
                            onChanged: (value) {
                              if (data != null) {
                                return;
                              }
                              setState(() {
                                _selectedPCR = value as bool;
                              });
                            },
                          ),
                        ),
                      ]),
                      if (_selectedPCR == true) ...[
                        TextFormField(
                          readOnly: data != null,
                          controller: _pcrCiclosController,
                          decoration: InputDecoration(
                            labelText: 'Ciclos',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) => FormValidators.required(
                            value,
                            condition: _selectedPCR,
                          ),
                          onChanged: (_) => checkValidFields(),
                        ),
                        spacingRow,
                        Row(
                          children: [
                            Expanded(
                              child: Text('Cardioversão ou desfibrilação:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            Expanded(
                              child: RadioListTile<bool>(
                                title: const Text('Sim'),
                                value: true,
                                groupValue:
                                    _selectedPCRCardioversaoDesfribilacao,
                                onChanged: (value) {
                                  if (data != null) {
                                    return;
                                  }
                                  setState(() {
                                    _selectedPCRCardioversaoDesfribilacao =
                                        value as bool;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<bool>(
                                title: const Text('Não'),
                                value: false,
                                groupValue:
                                    _selectedPCRCardioversaoDesfribilacao,
                                onChanged: (value) {
                                  if (data != null) {
                                    return;
                                  }
                                  setState(() {
                                    _selectedPCRCardioversaoDesfribilacao =
                                        value as bool;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        if (_selectedPCRCardioversaoDesfribilacao) ...[
                          spacingRow,
                          Text('Quantidade realizada:',
                              style: TextStyle(
                                fontSize: 16,
                              )),
                          Slider(
                            value: _quantidadeCardioversaoDesfribilacao ?? 1.0,
                            min: 1.0,
                            max: 10.0,
                            divisions: 9,
                            label:
                                _quantidadeCardioversaoDesfribilacao.toString(),
                            onChanged: (double value) {
                              setState(() {
                                _quantidadeCardioversaoDesfribilacao = value;
                              });
                            },
                          ),
                        ],
                        spacingRow,
                        Row(
                          children: [
                            Expanded(
                              child: Text('Medicações:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                height: 40,
                                child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => ModalAddMedicacao(
                                              onChanged: (value) {
                                                setState(() {
                                                  _listPCRMedicacoes.add(value);
                                                });
                                              },
                                            ));
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: _listPCRMedicacoes.map((medicacao) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    '${medicacao.nome}, ${medicacao.dose} doses às ${medicacao.horario}',
                                  ),
                                  trailing: data != null
                                      ? null
                                      : IconButton(
                                          icon: Icon(Icons.delete),
                                          color: Colors.red,
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(
                                                  'Confirmação',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: Text(
                                                  'Deseja remover medicação: ${medicacao.nome}?',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child: Text('Cancelar'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('Remover'),
                                                    onPressed: () {
                                                      setState(() {
                                                        _listPCRMedicacoes
                                                            .remove(medicacao);
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'Item removido'),
                                                        ),
                                                      );
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                ),
                                Divider(), // Add a divider between items if needed
                              ],
                            );
                          }).toList(),
                        ),
                        spacingRow,
                      ]
                    ]),
                  ),
                  Text(
                    'ECG',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text('Sim'),
                              value: true,
                              groupValue: _selectedECG,
                              onChanged: (value) {
                                if (data != null) {
                                  return;
                                }
                                setState(() {
                                  _selectedECG = value as bool;
                                  _ecgFocusNode.requestFocus();
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text('Não'),
                              value: false,
                              groupValue: _selectedECG,
                              onChanged: (value) {
                                if (data != null) {
                                  return;
                                }
                                setState(() {
                                  _selectedECG = value as bool;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      if (_selectedECG == true) ...[
                        TextFormField(
                          readOnly: data != null,
                          controller: _ecgController,
                          focusNode: _ecgFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Alteração',
                          ),
                          validator: (value) => FormValidators.required(
                            value,
                            condition: _selectedECG,
                          ),
                          onChanged: (_) => checkValidFields(),
                        ),
                        spacingRow,
                      ]
                    ]),
                  ),
                  Text(
                    'AVALIAÇÃO DE TRAUMAS',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  spacingRow,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      readOnly: data != null,
                      controller: _avaliacaoTraumasController,
                      decoration: InputDecoration(
                        labelText: 'Avaliação de traumas',
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  spacingRow,
                  Text(
                    'OUTROS',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  spacingRow,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      readOnly: data != null,
                      controller: _outrasAnotacoesController,
                      decoration: InputDecoration(
                        labelText:
                            'Outras anotações gerais referente a avaliação',
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  spacingRow,
                ],
              ))
        ],
      ),
    );
  }
}
