import 'package:flutter/material.dart';

class NewPP_I extends StatefulWidget {
  const NewPP_I({Key? key}) : super(key: key);

  @override
  State<NewPP_I> createState() => _NewPP_IState();
}

class _NewPP_IState extends State<NewPP_I> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _dateBirthController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _genderController = TextEditingController();
  final _formTransportController = TextEditingController();
  String _selectedGender = '';
  String _selectedTransport = '';

  final spacingRow = const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text('Indentificação do paciente',
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
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome';
                      }
                      return null;
                    },
                  ),
                  spacingRow,
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Idade'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a idade';
                      }
                      return null;
                    },
                  ),
                  spacingRow,
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Data de nascimento'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a data de nascimento';
                      }
                      return null;
                    },
                  ),
                  spacingRow,
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nome da mãe'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome da mãe';
                      }
                      return null;
                    },
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
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value.toString();
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
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value.toString();
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
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value.toString();
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
