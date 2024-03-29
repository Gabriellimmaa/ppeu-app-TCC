import 'package:flutter/material.dart';
import 'package:ppeu/constants/constants.dart';
import 'package:ppeu/core/notifier/mobileUnit.notifier.dart';
import 'package:ppeu/core/notifier/newPP.notifier.dart';
import 'package:ppeu/models/MobileUnit.model.dart';
import 'package:ppeu/models/PP.model.dart';
import 'package:ppeu/utils/formater/DateFormatter.util.dart';
import 'package:ppeu/utils/validation/FormValidators.validation.dart';
import 'package:provider/provider.dart';

class NewPP_I extends StatefulWidget {
  final PPModel? data;

  const NewPP_I({Key? key, this.data}) : super(key: key);

  @override
  State<NewPP_I> createState() => _NewPP_IState();
}

class _NewPP_IState extends State<NewPP_I> {
  bool isLoading = true;
  late PPModel? data;

  late GlobalKey<FormState> _formKey;

  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _nomeMaeController = TextEditingController();
  final _sexoController = TextEditingController();
  final _formaEncaminhamentoController = TextEditingController();
  String? _selectedSexo;
  String? _selectedTransport;
  List<MobileUnitModel> _mobileUnits = [];

  final _nomeFocusNode = FocusNode();
  final _idadeFocusNode = FocusNode();
  final _dataNascimentoFocusNode = FocusNode();
  final _nomeMaeFocusNode = FocusNode();

  Future<void> fetchMobileUnits(BuildContext context) async {
    MobileUnitNotifier mobileUnitNotifier =
        Provider.of<MobileUnitNotifier>(context, listen: false);

    var data = await mobileUnitNotifier.fetchAll();

    setState(() {
      _mobileUnits = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;
    NewPPNotifier newPPNotifier =
        Provider.of<NewPPNotifier>(context, listen: false);
    _formKey = newPPNotifier.formKeyIdentificacao;

    if (data != null) {
      _nomeController.text = data!.identificacao.nome;
      _idadeController.text = data!.identificacao.idade.toString();
      _dataNascimentoController.text = data!.identificacao.dataNascimento;
      _nomeMaeController.text = data!.identificacao.nomeMae;
      _sexoController.text = data!.identificacao.sexo;
      _formaEncaminhamentoController.text =
          data!.identificacao.formaEncaminhamento;
      _selectedSexo = data!.identificacao.sexo;
      _selectedTransport = data!.identificacao.formaEncaminhamento;
    }
    fetchMobileUnits(context);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    _dataNascimentoController.dispose();
    _nomeMaeController.dispose();
    _sexoController.dispose();
    _formaEncaminhamentoController.dispose();
    _nomeFocusNode.dispose();
    _idadeFocusNode.dispose();
    _dataNascimentoFocusNode.dispose();
    _nomeMaeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NewPPNotifier newPPNotifier =
        Provider.of<NewPPNotifier>(context, listen: false);

    Widget buildMobileUnitItem(String name) {
      return InkWell(
        onTap: () {
          setState(() {
            _selectedTransport = name;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
            Radio(
              value: name,
              groupValue: _selectedTransport,
              onChanged: (value) {
                setState(() {
                  _selectedTransport = value.toString();
                });
              },
            ),
          ],
        ),
      );
    }

    void updateFormData() {
      newPPNotifier.identificacao = IdentificacaoModel(
        nome: _nomeController.text,
        // idade: int.tryParse(_idadeController.text),
        idade: _idadeController.text,
        dataNascimento: _dataNascimentoController.text,
        nomeMae: _nomeMaeController.text,
        sexo: _selectedSexo!,
        formaEncaminhamento: _selectedTransport!,
      );
    }

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Identificação do paciente',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nomeController,
                          readOnly: data != null,
                          decoration: InputDecoration(labelText: 'Nome'),
                          validator: FormValidators.required,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_idadeFocusNode);
                          },
                          onSaved: (_) => updateFormData(),
                        ),
                        spacingRow,
                        TextFormField(
                          controller: _idadeController,
                          focusNode: _idadeFocusNode,
                          readOnly: data != null,
                          decoration: InputDecoration(labelText: 'Idade'),
                          validator: FormValidators.required,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                        ),
                        spacingRow,
                        TextFormField(
                          controller: _dataNascimentoController,
                          focusNode: _dataNascimentoFocusNode,
                          readOnly: true,
                          decoration:
                              InputDecoration(labelText: 'Data de nascimento'),
                          validator: FormValidators.required,
                          textInputAction: TextInputAction.next,
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (date != null) {
                              _dataNascimentoController.text = formatDate(
                                date,
                                format: FormatDate.diaMesAno,
                              );
                            }
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_nomeMaeFocusNode);
                          },
                        ),
                        spacingRow,
                        TextFormField(
                          controller: _nomeMaeController,
                          focusNode: _nomeMaeFocusNode,
                          readOnly: data != null,
                          decoration: InputDecoration(labelText: 'Nome da mãe'),
                          validator: FormValidators.required,
                          textInputAction: TextInputAction.done,
                        ),
                        spacingRow,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Sexo: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 'M',
                                  groupValue: _selectedSexo,
                                  onChanged: (value) {
                                    if (data != null) {
                                      return;
                                    }

                                    setState(() {
                                      _selectedSexo = value.toString();
                                    });
                                  },
                                ),
                                Text('M'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 'F',
                                  groupValue: _selectedSexo,
                                  onChanged: (value) {
                                    if (data != null) {
                                      return;
                                    }

                                    setState(() {
                                      _selectedSexo = value.toString();
                                    });
                                  },
                                ),
                                Text('F'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 'Outros',
                                  groupValue: _selectedSexo,
                                  onChanged: (value) {
                                    if (data != null) {
                                      return;
                                    }

                                    setState(() {
                                      _selectedSexo = value.toString();
                                    });
                                  },
                                ),
                                Text('Outros'),
                              ],
                            ),
                          ],
                        ),
                        if (_selectedSexo == null)
                          Text(
                            'Por favor, selecione o sexo.',
                            style: TextStyle(color: Colors.red),
                          ),
                        spacingRow,
                        Text(
                          'Forma de encaminhamento',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ..._mobileUnits.map((element) {
                          return buildMobileUnitItem(element.name);
                        }).toList(),
                        if (_selectedTransport == null)
                          Text(
                            'Por favor, selecione a forma de encaminhamento.',
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
