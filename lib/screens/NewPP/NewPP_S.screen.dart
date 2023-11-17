import 'package:flutter/material.dart';
import 'package:ppeu/constants/constants.dart';
import 'package:ppeu/core/notifier/newPP.notifier.dart';
import 'package:ppeu/models/PP.model.dart';
import 'package:ppeu/models/PP/Gestante.model.dart';
import 'package:ppeu/models/PP/Sintomas.model.dart';
import 'package:ppeu/utils/validation/FormValidators.validation.dart';
import 'package:ppeu/widgets/inputs/TimePickerTextField.widget.dart';
import 'package:provider/provider.dart';

class NewPP_S extends StatefulWidget {
  final PPModel? data;

  const NewPP_S({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<NewPP_S> createState() => _NewPP_SState();
}

class _NewPP_SState extends State<NewPP_S> {
  PPModel? data;

  late GlobalKey<FormState> _formKey;
  String? _selectedOrigem;
  String? _selectedCausasExternas;
  String? _selectedCausasExternasDescricao;
  String? _selectedClinica;
  bool _showTransferField = false;
  bool _showTraumaField = false;
  final _clinicaController = TextEditingController();

  final _sintomasHorarioController = TextEditingController();
  bool? _sintomasDorToracica;
  bool? _sintomasDeficitMotor;
  final _sintomasLocalController = TextEditingController();
  final _sintomasOutrosController = TextEditingController();

  final _sintomasLocalFocusNode = FocusNode();
  final _sintomasOutrosFocusNode = FocusNode();

  bool? _selectedGestante = false;
  final _gestanteBCFController = TextEditingController();
  final _gestanteIGController = TextEditingController();
  bool? _gestantePerdasVW;
  String? _gestanteTipoGestacao;
  final _gestanteBCFFocusNode = FocusNode();
  final _gestanteIGFocusNode = FocusNode();

  final _hipoteseDiagnosticoController = TextEditingController();
  final _enfermeiroResponsavelTransferenciaController = TextEditingController();
  final _hipoteseDiagnosticoFocusNode = FocusNode();
  final _enfermeiroResponsavelTransferenciaFocusNode = FocusNode();

  bool _validarClinica(String? value) {
    return optionsClinica.contains(value);
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;

    NewPPNotifier newPPNotifier =
        Provider.of<NewPPNotifier>(context, listen: false);
    _formKey = newPPNotifier.formKeySituacao;

    if (data != null) {
      _selectedOrigem = data!.situacao.origem;
      _selectedCausasExternas = data!.situacao.trauma;
      _selectedCausasExternasDescricao = data!.situacao.traumaDescricao;
      _selectedClinica = data!.situacao.clinica;
      _selectedGestante = data!.situacao.gestante != null;
      _clinicaController.text = data!.situacao.clinica;
      // _showClinica = data!.situacao.clinica;

      _sintomasHorarioController.text = data!.situacao.sintomas.horario;
      _sintomasDorToracica = data!.situacao.sintomas.dorToracica;
      _sintomasDeficitMotor = data!.situacao.sintomas.deficitMotor;
      _sintomasLocalController.text = data!.situacao.sintomas.local ?? '';
      _sintomasOutrosController.text = data!.situacao.sintomas.outros;

      if (_selectedGestante == true) {
        _gestanteBCFController.text = data!.situacao.gestante!.bcf;
        _gestanteIGController.text = data!.situacao.gestante!.ig;
        _gestantePerdasVW = data!.situacao.gestante!.perdasVW;
        _gestanteTipoGestacao = data!.situacao.gestante!.tipoGestacao;
      }

      _hipoteseDiagnosticoController.text = data!.situacao.hipoteseDiagnostico;
      _enfermeiroResponsavelTransferenciaController.text =
          data!.situacao.enfermeiroResponsavelTransferencia;
    }
  }

  @override
  void dispose() {
    _clinicaController.dispose();
    _sintomasHorarioController.dispose();
    _sintomasLocalController.dispose();
    _sintomasOutrosController.dispose();
    _sintomasLocalFocusNode.dispose();
    _sintomasOutrosFocusNode.dispose();
    _gestanteBCFController.dispose();
    _gestanteIGController.dispose();
    _gestanteBCFFocusNode.dispose();
    _gestanteIGFocusNode.dispose();
    _hipoteseDiagnosticoController.dispose();
    _hipoteseDiagnosticoFocusNode.dispose();
    _enfermeiroResponsavelTransferenciaFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NewPPNotifier newPPNotifier =
        Provider.of<NewPPNotifier>(context, listen: false);

    void updateFormData() {
      newPPNotifier.situacao = SituacaoModel(
        origem: _selectedOrigem ?? '',
        trauma: _selectedCausasExternas ?? '',
        traumaDescricao: _selectedCausasExternasDescricao,
        clinica: _selectedClinica ?? '',
        sintomas: SintomasModel(
          horario: _sintomasHorarioController.text,
          dorToracica: _sintomasDorToracica ?? false,
          deficitMotor: _sintomasDeficitMotor ?? false,
          local: _sintomasDorToracica == true || _sintomasDeficitMotor == true
              ? _sintomasLocalController.text
              : null,
          outros: _sintomasOutrosController.text,
        ),
        gestante: _selectedGestante == false
            ? null
            : GestanteModel(
                bcf: _gestanteBCFController.text,
                ig: _gestanteIGController.text,
                perdasVW: _gestantePerdasVW ?? false,
                tipoGestacao: _gestanteTipoGestacao ?? '',
              ),
        hipoteseDiagnostico: _hipoteseDiagnosticoController.text,
        enfermeiroResponsavelTransferencia:
            _enfermeiroResponsavelTransferenciaController.text,
      );
    }

    void checkValidFields() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.validate();
      }
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: const [
                  Text('Situação',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('Principais queixas, sintomas ou mecanismos de prejuízo',
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
                    'ORIGEM',
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
                        value: _selectedOrigem,
                        decoration: InputDecoration(
                          labelText: 'Origem',
                        ),
                        items: optionsOrigem
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        validator: FormValidators.required,
                        onSaved: (newValue) => updateFormData(),
                        onChanged: data != null
                            ? null
                            : (value) {
                                checkValidFields();
                                setState(() {
                                  _selectedOrigem = value as String?;
                                  _showTransferField = value == 'Transferência';
                                });
                              },
                      ),
                      if (_showTransferField) ...[
                        spacingRow,
                        TextFormField(
                          readOnly: data != null,
                          decoration: InputDecoration(labelText: 'Preencher'),
                        ),
                      ],
                      spacingRow,
                    ]),
                  ),
                  Text(
                    'SINTOMAS',
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
                        TimePickerTextField(
                          controller: _sintomasHorarioController,
                          readOnly: data != null,
                          labelText: 'Horário (início dos sintomas)',
                          validator: FormValidators.required,
                          onChanged: (_) => checkValidFields(),
                        ),
                        spacingRow,
                        DropdownButtonFormField(
                          value: _sintomasDorToracica,
                          decoration:
                              InputDecoration(labelText: 'Dor torácica'),
                          validator: FormValidators.required,
                          items: const [
                            DropdownMenuItem(
                              value: true,
                              child: Text(
                                'Sim',
                                style: TextStyle(
                                  color: Colors
                                      .black, // Set the desired menu item text color
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: false,
                              child: Text(
                                'Não',
                                style: TextStyle(
                                  color: Colors
                                      .black, // Set the desired menu item text color
                                ),
                              ),
                            ),
                          ],
                          onChanged: data != null
                              ? null
                              : (value) {
                                  checkValidFields();
                                  setState(() {
                                    _sintomasDorToracica = value as bool?;
                                  });
                                },
                        ),
                        spacingRow,
                        DropdownButtonFormField(
                          value: _sintomasDeficitMotor,
                          decoration:
                              InputDecoration(labelText: 'Déficit motor'),
                          items: const [
                            DropdownMenuItem(
                              value: true,
                              child: Text(
                                'Sim',
                                style: TextStyle(
                                  color: Colors
                                      .black, // Set the desired menu item text color
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: false,
                              child: Text(
                                'Não',
                                style: TextStyle(
                                  color: Colors
                                      .black, // Set the desired menu item text color
                                ),
                              ),
                            ),
                          ],
                          validator: FormValidators.required,
                          onChanged: data != null
                              ? null
                              : (value) {
                                  checkValidFields();
                                  setState(() {
                                    _sintomasDeficitMotor = value as bool?;
                                  });
                                },
                        ),
                        spacingRow,
                        if (_sintomasDorToracica == true ||
                            _sintomasDeficitMotor == true) ...[
                          TextFormField(
                              controller: _sintomasLocalController,
                              focusNode: _sintomasLocalFocusNode,
                              readOnly: data != null,
                              decoration: InputDecoration(
                                  labelText: 'Local (se for o caso)'),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_sintomasOutrosFocusNode);
                              }),
                          spacingRow,
                        ],
                        TextFormField(
                          controller: _sintomasOutrosController,
                          focusNode: _sintomasOutrosFocusNode,
                          readOnly: data != null,
                          decoration: InputDecoration(
                              labelText: 'Outros (se for o caso)'),
                          textInputAction: TextInputAction.next,
                        ),
                        spacingRow,
                      ],
                    ),
                  ),
                  Text(
                    'CLÍNICA',
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
                            value: _validarClinica(_selectedClinica)
                                ? _selectedClinica
                                : 'Outros',
                            decoration: InputDecoration(labelText: 'Selecione'),
                            items: optionsClinica
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: data != null
                                ? null
                                : ((value) {
                                    setState(() {
                                      _selectedClinica = value as String?;
                                    });
                                  }),
                          ),
                          if (!_validarClinica(_selectedClinica)) ...[
                            spacingRow,
                            TextFormField(
                              controller: _clinicaController,
                              readOnly: data != null,
                              decoration:
                                  InputDecoration(labelText: 'Complemento'),
                            )
                          ],
                          spacingRow,
                        ],
                      )),
                  Text(
                    'TIPO DE CAUSAS EXTERNAS',
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
                            value: _selectedCausasExternas,
                            decoration: InputDecoration(
                                labelText: 'Tipo de causas externas'),
                            items: optionsTipoTrauma
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: data != null
                                ? null
                                : (value) {
                                    setState(() {
                                      _selectedCausasExternas =
                                          value as String?;
                                      _showTraumaField = value == 'Outros' ||
                                          value == 'Queimadura';
                                      checkValidFields();
                                    });
                                  },
                          ),
                          if (_selectedCausasExternas ==
                              'Acidente de trânsito') ...[
                            spacingRow,
                            DropdownButtonFormField(
                              value: _selectedCausasExternasDescricao,
                              decoration:
                                  InputDecoration(labelText: 'Detalhes'),
                              items: optionsAcidenteTransito
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e,
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                      ))
                                  .toList(),
                              validator: (value) => FormValidators.required(
                                  value,
                                  condition: _selectedCausasExternas ==
                                      'Acidente de trânsito'),
                              onChanged: data != null
                                  ? null
                                  : (value) {
                                      setState(() {
                                        checkValidFields();
                                        _selectedCausasExternasDescricao =
                                            value as String;
                                      });
                                    },
                            ),
                          ],
                          if (_showTraumaField) ...[
                            spacingRow,
                            TextFormField(
                              readOnly: data != null,
                              decoration: InputDecoration(
                                  labelText: _selectedCausasExternas == 'Outros'
                                      ? 'Complemento'
                                      : '% de superfície corporal queimada'),
                              keyboardType: _selectedCausasExternas == 'Outros'
                                  ? TextInputType.text
                                  : TextInputType.number,
                              onChanged: (value) {
                                checkValidFields();
                                _selectedCausasExternasDescricao = value;
                              },
                              validator: (value) => FormValidators.required(
                                  value,
                                  condition: _showTraumaField),
                            )
                          ],
                          spacingRow,
                        ],
                      )),
                  Text(
                    'GESTANTE',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  Row(children: [
                    spacingRow,
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Sim'),
                        value: true,
                        groupValue: _selectedGestante,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }

                          setState(() {
                            _selectedGestante = value as bool;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Não'),
                        value: false,
                        groupValue: _selectedGestante,
                        onChanged: (value) {
                          if (data != null) {
                            return;
                          }
                          setState(() {
                            _selectedGestante = value as bool;
                          });
                        },
                      ),
                    ),
                  ]),
                  if (_selectedGestante == true)
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            spacingRow,
                            DropdownButtonFormField(
                              value: _gestanteTipoGestacao,
                              decoration: InputDecoration(
                                  labelText: 'Tipo de gestação'),
                              items: optionsGestacao
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) => FormValidators.required(
                                  value,
                                  condition: _selectedGestante == true),
                              onChanged: data != null
                                  ? null
                                  : (value) {
                                      checkValidFields();
                                      setState(() {
                                        _gestanteTipoGestacao =
                                            value as String?;
                                      });
                                    },
                            ),
                            spacingRow,
                            DropdownButtonFormField(
                              value: _gestantePerdasVW,
                              decoration:
                                  InputDecoration(labelText: 'Perdas VW'),
                              items: const [
                                DropdownMenuItem(
                                  value: true,
                                  child: Text(
                                    'Sim',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: false,
                                  child: Text(
                                    'Não',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                              validator: (value) => FormValidators.required(
                                  value,
                                  condition: _selectedGestante == true),
                              onChanged: data != null
                                  ? null
                                  : (value) {
                                      checkValidFields();
                                      setState(() {
                                        _gestantePerdasVW = value as bool?;
                                      });
                                    },
                            ),
                            spacingRow,
                            TextFormField(
                              controller: _gestanteIGController,
                              focusNode: _gestanteIGFocusNode,
                              readOnly: data != null,
                              decoration: InputDecoration(
                                  labelText: 'Idade Gestional (IG)'),
                              keyboardType: TextInputType.number,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_gestanteBCFFocusNode);
                              },
                              validator: (value) => FormValidators.required(
                                  value,
                                  condition: _selectedGestante == true),
                              onChanged: (_) => checkValidFields(),
                              textInputAction: TextInputAction.next,
                            ),
                            spacingRow,
                            TextFormField(
                              controller: _gestanteBCFController,
                              focusNode: _gestanteBCFFocusNode,
                              readOnly: data != null,
                              decoration: InputDecoration(
                                  labelText:
                                      'Batimentos cardíacos fetais (BCF)'),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              validator: (value) => FormValidators.required(
                                  value,
                                  condition: _selectedGestante == true),
                              onChanged: (_) => checkValidFields(),
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(
                                    _hipoteseDiagnosticoFocusNode);
                              },
                            ),
                            spacingRow,
                          ],
                        )),
                  spacingRow,
                  Text(
                    'HIPÓTESE DE DIAGNÓSTICO MÉDICO',
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
                      controller: _hipoteseDiagnosticoController,
                      focusNode: _hipoteseDiagnosticoFocusNode,
                      readOnly: data != null,
                      decoration: InputDecoration(labelText: 'Preencher'),
                      textInputAction: TextInputAction.next,
                      validator: FormValidators.required,
                      onChanged: (_) => checkValidFields(),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(
                            _enfermeiroResponsavelTransferenciaFocusNode);
                      },
                    ),
                  ),
                  spacingRow,
                  Text(
                    'ENFERMEIRO(A) RESPONSÁVEL PELA TRANSFERÊNCIA',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 2,
                    thickness: 2,
                    color: Colors.green,
                  ),
                  spacingRow,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: _enfermeiroResponsavelTransferenciaController,
                      focusNode: _enfermeiroResponsavelTransferenciaFocusNode,
                      readOnly: data != null,
                      validator: FormValidators.required,
                      onChanged: (_) => checkValidFields(),
                      decoration: InputDecoration(labelText: 'Preencher'),
                    ),
                  ),
                  spacingRow,
                ],
              )),
        ],
      ),
    );
  }
}
