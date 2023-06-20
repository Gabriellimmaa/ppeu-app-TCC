import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/models/PP.model.dart';

class NewPP_I extends StatefulWidget {
  final PPModel? data;

  const NewPP_I({Key? key, this.data}) : super(key: key);

  @override
  State<NewPP_I> createState() => _NewPP_IState();
}

class _NewPP_IState extends State<NewPP_I> {
  late PPModel? data;

  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _nomeMaeController = TextEditingController();
  final _sexoController = TextEditingController();
  final _formaEncaminhamentoController = TextEditingController();
  String _selectedSexo = '';
  String _selectedTransport = '';

  final _nomeFocusNode = FocusNode();
  final _idadeFocusNode = FocusNode();
  final _dataNascimentoFocusNode = FocusNode();
  final _nomeMaeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    data = widget.data;

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
  }

  @override
  void dispose() {
    _nomeController.dispose;
    _idadeController.dispose;
    _dataNascimentoController.dispose;
    _nomeMaeController.dispose;
    _sexoController.dispose;
    _formaEncaminhamentoController.dispose;
    _nomeFocusNode.dispose;
    _idadeFocusNode.dispose;
    _dataNascimentoFocusNode.dispose;
    _nomeMaeFocusNode.dispose;
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
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    readOnly: data != null,
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_idadeFocusNode);
                    },
                  ),
                  spacingRow,
                  TextFormField(
                    controller: _idadeController,
                    focusNode: _idadeFocusNode,
                    readOnly: data != null,
                    decoration: InputDecoration(labelText: 'Idade'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a idade';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_dataNascimentoFocusNode);
                    },
                  ),
                  spacingRow,
                  TextFormField(
                    controller: _dataNascimentoController,
                    focusNode: _dataNascimentoFocusNode,
                    readOnly: data != null,
                    decoration:
                        InputDecoration(labelText: 'Data de nascimento'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a data de nascimento';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_nomeMaeFocusNode);
                    },
                  ),
                  spacingRow,
                  TextFormField(
                    controller: _nomeMaeController,
                    focusNode: _nomeMaeFocusNode,
                    readOnly: data != null,
                    decoration: InputDecoration(labelText: 'Nome da mãe'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome da mãe';
                      }
                      return null;
                    },
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
                  spacingRow,
                  Text(
                    'Forma de encaminhamento',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      if (data != null) {
                        return;
                      }
                      setState(() {
                        _selectedTransport = 'SAMU básica';
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('SAMU básica'),
                        Radio(
                          value: 'SAMU básica',
                          groupValue: _selectedTransport,
                          onChanged: (value) {
                            if (data != null) {
                              return;
                            }

                            setState(() {
                              _selectedTransport = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (data != null) {
                        return;
                      }

                      setState(() {
                        _selectedTransport = 'SIATE';
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('SIATE'),
                        Radio(
                          value: 'SIATE',
                          groupValue: _selectedTransport,
                          onChanged: (value) {
                            if (data != null) {
                              return;
                            }

                            setState(() {
                              _selectedTransport = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (data != null) {
                        return;
                      }

                      setState(() {
                        _selectedTransport = 'SAMU avançada';
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('SAMU avançada'),
                        Radio(
                          value: 'SAMU avançada',
                          groupValue: _selectedTransport,
                          onChanged: (value) {
                            if (data != null) {
                              return;
                            }

                            setState(() {
                              _selectedTransport = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedTransport = 'Aéreo';
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Aéreo'),
                        Radio(
                          value: 'Aéreo',
                          groupValue: _selectedTransport,
                          onChanged: (value) {
                            if (data != null) {
                              return;
                            }

                            setState(() {
                              _selectedTransport = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (_formKey.currentState!.validate() &&
                  //         _selectedGender.isNotEmpty) {
                  //       // Form is valid and gender is selected
                  //       // Perform desired actions
                  //     }
                  //   },
                  //   child: Text('Enviar'),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
