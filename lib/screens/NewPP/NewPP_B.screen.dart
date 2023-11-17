import 'package:ppeu/core/notifier/newPP.notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ppeu/constants/constants.dart';
import 'package:ppeu/models/PP.model.dart';

import '../../utils/validation/FormValidators.validation.dart';

class NewPP_B extends StatefulWidget {
  final PPModel? data;

  const NewPP_B({Key? key, this.data}) : super(key: key);

  @override
  State<NewPP_B> createState() => _NewPP_BState();
}

class _NewPP_BState extends State<NewPP_B> {
  PPModel? data;

  late GlobalKey<FormState> _formKey;
  final _historicaClinicaController = TextEditingController();
  final _alergiasController = TextEditingController(text: null);
  final _comorbidadesController = TextEditingController(text: null);
  final _viciosController = TextEditingController(text: null);
  final _medicamentosEmUsoController = TextEditingController(text: null);
  final _historicoInternacoesController = TextEditingController();
  final _cirurgiaPreviaController = TextEditingController(text: null);
  final _lesoesController = TextEditingController(text: null);
  final _alteracoesLaboratoriaisController = TextEditingController(text: null);
  final _jejumController = TextEditingController(text: null);
  final _alergiasFocusNode = FocusNode();
  final _comorbidadesFocusNode = FocusNode();
  final _viciosFocusNode = FocusNode();
  final _medicamentosEmUsoFocusNode = FocusNode();
  final _historicoInternacoesFocusNode = FocusNode();
  final _cirurgiaPreviaFocusNode = FocusNode();
  final _lesoesFocusNode = FocusNode();
  final _alteracoesLaboratoriaisFocusNode = FocusNode();
  final _jejumFocusNode = FocusNode();

  bool? _selectedAlergias = false;
  bool? _selectedComorbidades = false;
  bool? _selectedVices = false;
  bool? _selectedMedicationsInUse = false;
  bool? _selectedHospitalizationHistory = false;
  bool? _selectedPreviousSurgery = false;
  bool? _selectedInjuries = false;
  bool? _selectedLaboratoryAlterations = false;
  bool? _selectedJejum = false;
  bool? _selectedPrecaucoes = false;
  late String _precaucoes = '';

  @override
  void initState() {
    super.initState();
    data = widget.data;
    NewPPNotifier newPPNotifier =
        Provider.of<NewPPNotifier>(context, listen: false);
    _formKey = newPPNotifier.formKeyBreveHistorico;

    if (data != null) {
      _historicaClinicaController.text = data!.breveHistorico.historicaClinica;
      _alergiasController.text = data!.breveHistorico.alergias!;
      _comorbidadesController.text = data!.breveHistorico.comorbidades!;
      _viciosController.text = data!.breveHistorico.vicios!;
      _medicamentosEmUsoController.text =
          data!.breveHistorico.medicamentoEmUso!;
      _historicoInternacoesController.text =
          data!.breveHistorico.historicoInternacoes!;
      _cirurgiaPreviaController.text = data!.breveHistorico.cirurgiaPrevia!;
      _lesoesController.text = data!.breveHistorico.lesoes!;
      _alteracoesLaboratoriaisController.text =
          data!.breveHistorico.alteracoesLaboratoriais!;
      _jejumController.text = data!.breveHistorico.jejum!;

      _selectedAlergias = data!.breveHistorico.alergias == '' ? false : true;
      _selectedComorbidades = data!.breveHistorico.comorbidades!.isNotEmpty;
      _selectedVices = data!.breveHistorico.vicios!.isNotEmpty;
      _selectedMedicationsInUse =
          data!.breveHistorico.medicamentoEmUso!.isNotEmpty;
      _selectedHospitalizationHistory =
          data!.breveHistorico.historicoInternacoes!.isNotEmpty;
      _selectedPreviousSurgery =
          data!.breveHistorico.cirurgiaPrevia!.isNotEmpty;
      _selectedInjuries = data!.breveHistorico.lesoes!.isNotEmpty;
      _selectedLaboratoryAlterations =
          data!.breveHistorico.alteracoesLaboratoriais!.isNotEmpty;
      _precaucoes = data!.breveHistorico.precaucoes;
      if (_precaucoes != '') {
        _selectedPrecaucoes = true;
      }
      _selectedJejum = data!.breveHistorico.jejum!.isNotEmpty;
    }
  }

  @override
  void dispose() {
    _historicaClinicaController.dispose();
    _alergiasController.dispose();
    _comorbidadesController.dispose();
    _viciosController.dispose();
    _medicamentosEmUsoController.dispose();
    _historicoInternacoesController.dispose();
    _cirurgiaPreviaController.dispose();
    _lesoesController.dispose();
    _alteracoesLaboratoriaisController.dispose();
    _jejumController.dispose();
    _alergiasFocusNode.dispose();
    _comorbidadesFocusNode.dispose();
    _viciosFocusNode.dispose();
    _medicamentosEmUsoFocusNode.dispose();
    _historicoInternacoesFocusNode.dispose();
    _cirurgiaPreviaFocusNode.dispose();
    _lesoesFocusNode.dispose();
    _alteracoesLaboratoriaisFocusNode.dispose();
    _jejumFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NewPPNotifier newPPNotifier =
        Provider.of<NewPPNotifier>(context, listen: false);

    void checkValidFields() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.validate();
      }
    }

    void updateFormData() {
      newPPNotifier.breveHistorico = BreveHistoricoModel(
        historicaClinica: _historicaClinicaController.text,
        alergias: _alergiasController.text,
        comorbidades: _comorbidadesController.text,
        vicios: _viciosController.text,
        medicamentoEmUso: _medicamentosEmUsoController.text,
        historicoInternacoes: _historicoInternacoesController.text,
        cirurgiaPrevia: _cirurgiaPreviaController.text,
        lesoes: _lesoesController.text,
        alteracoesLaboratoriais: _alteracoesLaboratoriaisController.text,
        jejum: _jejumController.text,
        precaucoes: _precaucoes,
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
                  Text('Breve histórico',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                      'Queixa principal, histórico medico, medicação e alergias',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ],
              )),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'HISTÓRIA CLÍNICA RESUMIDA',
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
                    TextFormField(
                      controller: _historicaClinicaController,
                      readOnly: data != null,
                      decoration: InputDecoration(
                        labelText: 'Breve descrição história clínica',
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.done,
                      onSaved: (_) => updateFormData(),
                      validator: FormValidators.required,
                      onChanged: (_) => checkValidFields(),
                    ),
                    spacingRow,
                  ]),
                ),
                Text(
                  'ALERGIAS',
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
                      child: RadioListTile(
                        title: const Text('Sim'),
                        value: true,
                        groupValue: _selectedAlergias,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedAlergias = value as bool;
                            _alergiasFocusNode.requestFocus();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Não'),
                        value: false,
                        groupValue: _selectedAlergias,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedAlergias = value as bool;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedAlergias == true)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        controller: _alergiasController,
                        focusNode: _alergiasFocusNode,
                        readOnly: data != null,
                        decoration: InputDecoration(
                          labelText: 'Quais alergias',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        validator: (value) => FormValidators.required(value,
                            condition: _selectedAlergias == true),
                        onChanged: (_) => checkValidFields(),
                      ),
                      spacingRow,
                    ]),
                  ),
                Text(
                  'COMORBIDADES',
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
                      child: RadioListTile(
                        title: const Text('Sim'),
                        value: true,
                        groupValue: _selectedComorbidades,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedComorbidades = value as bool;
                            _comorbidadesFocusNode.requestFocus();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Não'),
                        value: false,
                        groupValue: _selectedComorbidades,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedComorbidades = value as bool;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedComorbidades == true)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        controller: _comorbidadesController,
                        focusNode: _comorbidadesFocusNode,
                        readOnly: data != null,
                        decoration: InputDecoration(
                          labelText: 'Quais comorbidades',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        validator: (value) => FormValidators.required(value,
                            condition: _selectedComorbidades == true),
                        onChanged: (_) => checkValidFields(),
                      ),
                      spacingRow,
                    ]),
                  ),
                Text(
                  'VÍCIOS',
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
                      child: RadioListTile(
                        title: const Text('Sim'),
                        value: true,
                        groupValue: _selectedVices,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedVices = value as bool;
                            _viciosFocusNode.requestFocus();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Não'),
                        value: false,
                        groupValue: _selectedVices,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedVices = value as bool;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedVices == true)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        controller: _viciosController,
                        focusNode: _viciosFocusNode,
                        readOnly: data != null,
                        decoration: InputDecoration(
                          labelText: 'Quais vícios',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        validator: (value) => FormValidators.required(value,
                            condition: _selectedVices == true),
                        onChanged: (_) => checkValidFields(),
                      ),
                      spacingRow,
                    ]),
                  ),
                Text(
                  'MEDICAMENTOS EM USO',
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
                      child: RadioListTile(
                        title: const Text('Sim'),
                        value: true,
                        groupValue: _selectedMedicationsInUse,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedMedicationsInUse = value as bool;
                            _medicamentosEmUsoFocusNode.requestFocus();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Não'),
                        value: false,
                        groupValue: _selectedMedicationsInUse,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedMedicationsInUse = value as bool;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedMedicationsInUse == true)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        controller: _medicamentosEmUsoController,
                        focusNode: _medicamentosEmUsoFocusNode,
                        readOnly: data != null,
                        decoration: InputDecoration(
                          labelText: 'Quais medicamentos',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        validator: (value) => FormValidators.required(value,
                            condition: _selectedMedicationsInUse == true),
                        onChanged: (_) => checkValidFields(),
                      ),
                      spacingRow,
                    ]),
                  ),
                Text(
                  'HISTÓRICO DE INTERNAÇÕES',
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
                      child: RadioListTile(
                        title: const Text('Sim'),
                        value: true,
                        groupValue: _selectedHospitalizationHistory,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedHospitalizationHistory = value as bool;
                            _historicoInternacoesFocusNode.requestFocus();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Não'),
                        value: false,
                        groupValue: _selectedHospitalizationHistory,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedHospitalizationHistory = value as bool;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedHospitalizationHistory == true)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        controller: _historicoInternacoesController,
                        focusNode: _historicoInternacoesFocusNode,
                        readOnly: data != null,
                        decoration: InputDecoration(
                          labelText: 'Quais históricos de internações',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        validator: (value) => FormValidators.required(value,
                            condition: _selectedHospitalizationHistory == true),
                        onChanged: (_) => checkValidFields(),
                      ),
                      spacingRow,
                    ]),
                  ),
                Text(
                  'CIRURGIA PRÉVIA',
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
                      child: RadioListTile(
                        title: const Text('Sim'),
                        value: true,
                        groupValue: _selectedPreviousSurgery,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedPreviousSurgery = value as bool;
                            _cirurgiaPreviaFocusNode.requestFocus();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Não'),
                        value: false,
                        groupValue: _selectedPreviousSurgery,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedPreviousSurgery = value as bool;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedPreviousSurgery == true)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        controller: _cirurgiaPreviaController,
                        focusNode: _cirurgiaPreviaFocusNode,
                        readOnly: data != null,
                        decoration: InputDecoration(
                          labelText: 'Quais cirurgias prévias',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        validator: (value) => FormValidators.required(value,
                            condition: _selectedPreviousSurgery == true),
                        onChanged: (_) => checkValidFields(),
                      ),
                      spacingRow,
                    ]),
                  ),
                Text(
                  'LESÕES',
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
                      child: RadioListTile(
                        title: const Text('Sim'),
                        value: true,
                        groupValue: _selectedInjuries,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedInjuries = value as bool;
                            _lesoesFocusNode.requestFocus();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Não'),
                        value: false,
                        groupValue: _selectedInjuries,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedInjuries = value as bool;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedInjuries == true)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        controller: _lesoesController,
                        focusNode: _lesoesFocusNode,
                        readOnly: data != null,
                        decoration: InputDecoration(
                          labelText: 'Grau e local da lesão',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        validator: (value) => FormValidators.required(value,
                            condition: _selectedInjuries == true),
                        onChanged: (_) => checkValidFields(),
                      ),
                      spacingRow,
                    ]),
                  ),
                Text(
                  'ALTERAÇÕES LABORATORIAIS',
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
                      child: RadioListTile(
                        title: const Text('Sim'),
                        value: true,
                        groupValue: _selectedLaboratoryAlterations,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedLaboratoryAlterations = value as bool;
                            _alteracoesLaboratoriaisFocusNode.requestFocus();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Não'),
                        value: false,
                        groupValue: _selectedLaboratoryAlterations,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedLaboratoryAlterations = value as bool;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedLaboratoryAlterations == true)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        controller: _alteracoesLaboratoriaisController,
                        focusNode: _alteracoesLaboratoriaisFocusNode,
                        readOnly: data != null,
                        decoration: InputDecoration(
                          labelText: 'Quais alterações',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        validator: (value) => FormValidators.required(value,
                            condition: _selectedLaboratoryAlterations == true),
                        onChanged: (_) => checkValidFields(),
                      ),
                      spacingRow,
                    ]),
                  ),
                Text(
                  'PRECAUÇÕES',
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
                      child: RadioListTile(
                        title: const Text('Sim'),
                        value: true,
                        groupValue: _selectedPrecaucoes,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedPrecaucoes = value as bool;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Não'),
                        value: false,
                        groupValue: _selectedPrecaucoes,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedPrecaucoes = value as bool;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedPrecaucoes == true)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      DropdownButtonFormField(
                        value: _precaucoes == '' ? null : _precaucoes,
                        decoration: InputDecoration(labelText: 'Precauções'),
                        items: optionsPrecaucoes
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
                                checkValidFields();
                                setState(() {
                                  _precaucoes = value as String;
                                });
                              },
                        validator: (value) => FormValidators.required(value,
                            condition: _selectedPrecaucoes == true),
                      ),
                      spacingRow,
                    ]),
                  ),
                Text(
                  'JEJUM',
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
                      child: RadioListTile(
                        title: const Text('Sim'),
                        value: true,
                        groupValue: _selectedJejum,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedJejum = value as bool;
                            _jejumFocusNode.requestFocus();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Não'),
                        value: false,
                        groupValue: _selectedJejum,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedJejum = value as bool;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedJejum == true)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        controller: _jejumController,
                        focusNode: _jejumFocusNode,
                        readOnly: data != null,
                        decoration: InputDecoration(
                          labelText: 'Tempo de jejum',
                        ),
                        textInputAction: TextInputAction.done,
                        validator: (value) => FormValidators.required(value,
                            condition: _selectedJejum == true),
                        onChanged: (_) => checkValidFields(),
                      ),
                      spacingRow,
                    ]),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
