import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/models/PP.model.dart';

class NewPP_B extends StatefulWidget {
  final PPModel? data;

  const NewPP_B({Key? key, this.data}) : super(key: key);

  @override
  State<NewPP_B> createState() => _NewPP_BState();
}

class _NewPP_BState extends State<NewPP_B> {
  PPModel? data;

  final _formKey = GlobalKey<FormState>();
  final _historicaClinicaController = TextEditingController();
  final _alergiasController = TextEditingController();
  final _comorbidadesController = TextEditingController();
  final _viciosController = TextEditingController();
  final _medicamentosEmUsoController = TextEditingController();
  final _historicoInternacoesController = TextEditingController();
  final _cirurgiaPreviaController = TextEditingController();
  final _lesoesController = TextEditingController();
  final _alteracoesLaboratoriaisController = TextEditingController();
  final _jejumController = TextEditingController();
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
  bool? _selectedComorbidity = false;
  bool? _selectedVices = false;
  bool? _selectedMedicationsInUse = false;
  bool? _selectedHospitalizationHistory = false;
  bool? _selectedPreviousSurgery = false;
  bool? _selectedInjuries = false;
  bool? _selectedLaboratoryAlterations = false;
  bool? _selectedJejum = false;
  bool? _selectedPrecaucoes = false;
  String? _precaucoes;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    if (data != null) {
      _historicaClinicaController.text = data!.breveHistorico.historicaClinica;
      _alergiasController.text = data!.breveHistorico.alergias ?? '';
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

      _selectedAlergias = data!.breveHistorico.alergias == null ? false : true;
      _selectedComorbidity = data!.breveHistorico.comorbidades!.isNotEmpty;
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
      if (_precaucoes != null) {
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
                        groupValue: _selectedComorbidity,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedComorbidity = value as bool;
                            _comorbidadesFocusNode.requestFocus();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Não'),
                        value: false,
                        groupValue: _selectedComorbidity,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedComorbidity = value as bool;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedComorbidity == true)
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
                        value: _precaucoes,
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
                                setState(() {
                                  _precaucoes = value as String;
                                });
                              },
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
