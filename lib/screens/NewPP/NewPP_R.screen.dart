import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/core/notifier/hospitalUnit.notifier.dart';
import 'package:ppue/core/notifier/user.notifier.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:ppue/models/PP/Pertences.model.dart';
import 'package:ppue/models/PP/ResponsavelRecebimento.model.dart';
import 'package:ppue/screens/NewPP/widgets/ModalAddEncaminhamento.widget.dart';
import 'package:ppue/screens/NewPP/widgets/ModalAddFamiliarAdmissao.widget.dart';
import 'package:ppue/screens/NewPP/widgets/ModalAddResponsavelRecebimento.widget.dart';
import 'package:ppue/core/notifier/newPP.notifier.dart';
import 'package:ppue/utils/formater/LimitCharacters.util.dart';
import 'package:ppue/utils/validation/FormValidators.validation.dart';
import 'package:provider/provider.dart';

class NewPP_R extends StatefulWidget {
  final PPModel? data;
  const NewPP_R({Key? key, this.data}) : super(key: key);

  @override
  State<NewPP_R> createState() => _NewPP_RState();
}

class _NewPP_RState extends State<NewPP_R> {
  PPModel? data;

  late GlobalKey<FormState> _formKey;
  String? _selectedEncaminhamento;

  List<dynamic> _listFamiliarPresente = [];
  String? _responsavelRecebimento;
  List<DropdownMenuItem<String>> _hospitalUnitDropdownItems = [];
  List<DropdownMenuItem<String>> _usersDropdownItems = [];
  final _pertencesNomeController = TextEditingController();
  final _pertencesParentescoController = TextEditingController();
  final _pertencesParentescoFocusNode = FocusNode();

  Future<void> fetchHospitalUnitsAndBuildDropdown(BuildContext context) async {
    HospitalUnitNotifier hospitalUnitNotifier =
        Provider.of<HospitalUnitNotifier>(context, listen: false);

    List<dynamic> data = await hospitalUnitNotifier.fetchAll();
    _hospitalUnitDropdownItems = data.map((element) {
      return DropdownMenuItem<String>(
        value: '${element.id.toString()}::${element.name}',
        child: Text(
          limitCharacters(element.name, 30),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
    }).toList();

    setState(() {}); // Força o rebuild do widget
  }

  Future<void> fetchUsersAndBuildDropdown(BuildContext context) async {
    UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);
    List<dynamic> data = await userNotifier.fetchAll();
    _usersDropdownItems = data.map((element) {
      return DropdownMenuItem<String>(
        value: '${element.name}::${element.role}::${element.taxId}',
        child: Text(
          limitCharacters(element.name, 30),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
    }).toList();

    setState(() {}); // Força o rebuild do widget
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;

    NewPPNotifier newPPNotifier =
        Provider.of<NewPPNotifier>(context, listen: false);
    _formKey = newPPNotifier.formKeyRecomendacoes;

    if (data != null) {
      bool hasPertences = data!.recomendacoes.pertences != null ? true : false;

      _hospitalUnitDropdownItems.add(DropdownMenuItem(
          value: data!.recomendacoes.encaminhamento,
          child: Text(data!.recomendacoes.encaminhamento,
              style: TextStyle(
                color: Colors.black,
              ))));
      _selectedEncaminhamento = data!.recomendacoes.encaminhamento;

      _responsavelRecebimento =
          '${data!.recomendacoes.responsavelRecebimento.nome}::${data!.recomendacoes.responsavelRecebimento.cargo}::${data!.recomendacoes.responsavelRecebimento.cpf}';
      _usersDropdownItems.add(DropdownMenuItem(
          value:
              '${data!.recomendacoes.responsavelRecebimento.nome}::${data!.recomendacoes.responsavelRecebimento.cargo}::${data!.recomendacoes.responsavelRecebimento.cpf}',
          child: Text(
              '${data!.recomendacoes.responsavelRecebimento.nome} - ${data!.recomendacoes.responsavelRecebimento.cargo}',
              style: TextStyle(
                color: Colors.black,
              ))));

      if (hasPertences) {
        _pertencesNomeController.text = data!.recomendacoes.pertences!.nome;
        _pertencesParentescoController.text =
            data!.recomendacoes.pertences!.parentesco;
      }

      _listFamiliarPresente = data!.recomendacoes.familiarPresente;
    } else {
      // fetchHospitalUnitsAndBuildDropdown(context);
      // fetchUsersAndBuildDropdown(context);
    }
  }

  @override
  void dispose() {
    _pertencesNomeController.dispose;
    _pertencesParentescoController.dispose;
    _pertencesParentescoFocusNode.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NewPPNotifier newPPNotifier =
        Provider.of<NewPPNotifier>(context, listen: false);
    UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);

    void updateFormData() {
      var parsedResponsavelRecebimento = _responsavelRecebimento!.split('::');
      newPPNotifier.recomendacoes = RecomendacoesModel(
          encaminhamento: _selectedEncaminhamento!.split('::')[1],
          familiarPresente: _listFamiliarPresente,
          pertences: _pertencesNomeController.text.isNotEmpty
              ? PertencesModel(
                  nome: _pertencesNomeController.text,
                  parentesco: _pertencesParentescoController.text)
              : null,
          responsavelRecebimento: ResponsavelRecebimentoModel(
              nome: parsedResponsavelRecebimento[0],
              cargo: parsedResponsavelRecebimento[1],
              cpf: parsedResponsavelRecebimento[2]));
    }

    void checkValidFields() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.validate();
      }
    }

    void updateUsersDropdown(id) async {
      List<dynamic> data = await userNotifier.filterByHospitalUnit(id: id);

      setState(() {
        _usersDropdownItems = data.map((element) {
          return DropdownMenuItem<String>(
            value: '${element.name}::${element.role}::${element.taxId}',
            child: Text(
              limitCharacters(element.name, 30),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          );
        }).toList();
      });
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: const [
                  Text('Recomendações',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('Ações imediatas, tempo crítico ou não',
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
                  'ENCAMINHAMENTO',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.green,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          value: _selectedEncaminhamento,
                          decoration: InputDecoration(
                              labelText: 'Local encaminhamento'),
                          items: _hospitalUnitDropdownItems,
                          onChanged: data != null
                              ? null
                              : (value) {
                                  updateUsersDropdown(int.parse(value
                                      .toString()
                                      .split('::')[0]
                                      .toString()));
                                  setState(() {
                                    _selectedEncaminhamento = value as String?;
                                  });
                                },
                          validator: FormValidators.required,
                          onSaved: (value) {
                            updateFormData();
                          },
                        ),
                      ),
                      spacingColumn,
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (data != null) {
                              return;
                            }

                            showDialog(
                              context: context,
                              builder: (context) => ModalAddEncaminhamento(
                                onChanged: (value) {
                                  setState(() {
                                    _hospitalUnitDropdownItems.add(
                                      DropdownMenuItem(
                                          value: value,
                                          child: Text(value,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ))),
                                    );
                                    _selectedEncaminhamento = value;
                                    checkValidFields();
                                  });
                                },
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                spacingRow,
                Text(
                  'RESPONSÁVEL PELO RECEBIMENTO',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.green,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          value: _responsavelRecebimento,
                          decoration: InputDecoration(
                              labelText: 'Selecione o profissional'),
                          items: _usersDropdownItems,
                          onChanged: data != null
                              ? null
                              : (value) {
                                  checkValidFields();
                                  setState(() {
                                    var _value = value as String;
                                    var parsedValue = _value.split('::');
                                    _responsavelRecebimento =
                                        '${parsedValue[0]}::${parsedValue[1]}::${parsedValue[2]}';
                                  });
                                },
                          validator: FormValidators.required,
                          onSaved: (value) {
                            updateFormData();
                          },
                        ),
                      ),
                      spacingColumn,
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (data != null) {
                              return;
                            }

                            showDialog(
                                context: context,
                                builder: (context) =>
                                    ModalAddResponsavelRecebimento(
                                      onChanged: (value) {
                                        setState(() {
                                          var parsedValue = value.split('::');
                                          _usersDropdownItems.add(
                                            DropdownMenuItem(
                                                value: parsedValue[0],
                                                child: Text(
                                                    '${parsedValue[0]}::${parsedValue[1]}::${parsedValue[2]}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ))),
                                          );
                                          _responsavelRecebimento =
                                              '${parsedValue[0]}::${parsedValue[1]}::${parsedValue[2]}';
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
                    ],
                  ),
                ),
                spacingRow,
                Text(
                  'FAMÍLIA PRESENTE NA ADMISSÃO',
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
                            child: Text('Adicionar Familiar:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
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
                                  if (data != null) {
                                    return;
                                  }

                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          ModalAddFamiliarAdmissao(
                                            onChanged: (value) {
                                              setState(() {
                                                _listFamiliarPresente
                                                    .add(value);
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
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _listFamiliarPresente.length,
                          padding: EdgeInsets.all(0),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                _listFamiliarPresente[index],
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
                                            title: Text('Confirmação',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            content: Text(
                                                'Deseja remover o familiar ${_listFamiliarPresente[index]}?'),
                                            actions: [
                                              TextButton(
                                                child: Text('Cancelar'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text('Remover'),
                                                onPressed: () {
                                                  setState(() {
                                                    _listFamiliarPresente
                                                        .removeAt(index);
                                                  });
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content:
                                                          Text('Item removido'),
                                                    ),
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            );
                          }),
                    ])),
                spacingRow,
                Text(
                  'PERTENCES',
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
                        controller: _pertencesNomeController,
                        readOnly: data != null,
                        decoration: InputDecoration(
                          labelText: 'Nome da pessoa entregue',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          _pertencesParentescoFocusNode.requestFocus();
                        },
                        onSaved: (value) {
                          updateFormData();
                        },
                      ),
                      spacingRow,
                      TextFormField(
                        controller: _pertencesParentescoController,
                        readOnly: data != null,
                        focusNode: _pertencesParentescoFocusNode,
                        decoration: InputDecoration(
                          labelText: 'Parentesco',
                        ),
                        onSaved: (value) {
                          updateFormData();
                        },
                      ),
                      spacingRow,
                    ])),
              ],
            ),
          )
        ],
      ),
    );
  }
}
