import 'package:flutter/material.dart';

class NewPP_A extends StatefulWidget {
  const NewPP_A({Key? key}) : super(key: key);

  @override
  State<NewPP_A> createState() => _NewPP_AState();
}

class _NewPP_AState extends State<NewPP_A> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedPain;
  String? _selectedIntubation;
  String? _selectedOxygen;
  String? _selectedMedicine;

  String? _selectedCentralAccess;
  String? _selectedPeripheralAccess;
  String? _selectedIntraosseousAccess;

  String? _selectedChestDrainage;

  String? _selectedGastricCatheter = 'Não';
  String? _selectedBladderCatheter;
  String? _selectedPCR;
  String? _selectedPCRMedicine;
  String? _selectedCardioversionDesgibrillation;
  String? _selectedECG;

  final spacingRow = const SizedBox(height: 16);
  final spacingColumn = const SizedBox(width: 16);

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
                        child: RadioListTile<String>(
                          title: const Text('Sim'),
                          value: 'Sim',
                          groupValue: _selectedPain,
                          onChanged: (value) {
                            setState(() {
                              _selectedPain = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Não'),
                          value: 'Não',
                          groupValue: _selectedPain,
                          onChanged: (value) {
                            setState(() {
                              _selectedPain = value;
                            });
                          },
                        ),
                      ),
                    ]),
                  ),
                  if (_selectedPain == 'Sim') ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Local',
                            ),
                          ),
                        ),
                        spacingColumn,
                        Expanded(
                            child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Intensidade',
                          ),
                        ))
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
                                decoration: InputDecoration(
                                  labelText: 'PA',
                                ),
                              ),
                            ),
                            spacingColumn,
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Temperatura',
                                ),
                              ),
                            ),
                          ],
                        ),
                        spacingRow,
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'FR',
                                ),
                              ),
                            ),
                            spacingColumn,
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'FC',
                                ),
                              ),
                            ),
                          ],
                        ),
                        spacingRow,
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Glicemia',
                                ),
                              ),
                            ),
                            spacingColumn,
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'SP02',
                                ),
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'AO',
                              ),
                            ),
                          ),
                          spacingColumn,
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'RV',
                              ),
                            ),
                          ),
                        ],
                      ),
                      spacingRow,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'RM',
                        ),
                      ),
                      spacingRow,
                      DropdownButtonFormField(
                        decoration: InputDecoration(labelText: 'AVDI'),
                        items: const [
                          DropdownMenuItem(
                            value: 'Alerta',
                            child: Text('Alerta'),
                          ),
                          DropdownMenuItem(
                            value: 'Dor',
                            child: Text('Dor'),
                          ),
                          DropdownMenuItem(
                            value: 'Voz',
                            child: Text('Voz'),
                          ),
                          DropdownMenuItem(
                            value: 'Inconciente',
                            child: Text('Inconciente'),
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            // _selectedOrigin = value as String?;
                            // _showTransferField = value == 'Transferência';
                          });
                        },
                      ),
                      spacingRow,
                      DropdownButtonFormField(
                        decoration: InputDecoration(labelText: 'Pupilas'),
                        items: const [
                          DropdownMenuItem(
                            value: 'Isocóricas',
                            child: Text('Isocóricas'),
                          ),
                          DropdownMenuItem(
                            value: 'Mitióticas',
                            child: Text('Mitióticas'),
                          ),
                          DropdownMenuItem(
                            value: 'Midriáticas',
                            child: Text('Midriáticas'),
                          ),
                          DropdownMenuItem(
                            value: 'Anisocóricas',
                            child: Text('Anisocóricas'),
                          ),
                          DropdownMenuItem(
                            value: 'D>E',
                            child: Text('D>E'),
                          ),
                          DropdownMenuItem(
                            value: 'E>D',
                            child: Text('E>D'),
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            // _selectedOrigin = value as String?;
                            // _showTransferField = value == 'Transferência';
                          });
                        },
                      ),
                      spacingRow,
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
                          child: RadioListTile<String>(
                            title: const Text('Sim'),
                            value: 'Sim',
                            groupValue: _selectedIntubation,
                            onChanged: (value) {
                              setState(() {
                                _selectedIntubation = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Não'),
                            value: 'Não',
                            groupValue: _selectedIntubation,
                            onChanged: (value) {
                              setState(() {
                                _selectedIntubation = value;
                              });
                            },
                          ),
                        ),
                      ]),
                      if (_selectedIntubation == 'Sim')
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Horário',
                                    ),
                                  ),
                                ),
                                spacingColumn,
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'N do tubo',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                )
                              ],
                            ),
                            spacingRow,
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Responsável',
                              ),
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
                      Row(children: [
                        spacingRow,
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Sim'),
                            value: 'Sim',
                            groupValue: _selectedOxygen,
                            onChanged: (value) {
                              setState(() {
                                _selectedOxygen = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Não'),
                            value: 'Não',
                            groupValue: _selectedOxygen,
                            onChanged: (value) {
                              setState(() {
                                _selectedOxygen = value;
                              });
                            },
                          ),
                        ),
                      ]),
                      if (_selectedOxygen == 'Sim')
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'MAF L/M',
                                    ),
                                  ),
                                ),
                                spacingColumn,
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Catéter L/M',
                                    ),
                                  ),
                                )
                              ],
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
                          child: RadioListTile<String>(
                            title: const Text('Sim'),
                            value: 'Sim',
                            groupValue: _selectedMedicine,
                            onChanged: (value) {
                              setState(() {
                                _selectedMedicine = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Não'),
                            value: 'Não',
                            groupValue: _selectedMedicine,
                            onChanged: (value) {
                              setState(() {
                                _selectedMedicine = value;
                              });
                            },
                          ),
                        ),
                      ]),
                      if (_selectedMedicine == 'Sim')
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Espécie de medicação',
                              ),
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
                        child: RadioListTile<String>(
                          title: const Text('Sim'),
                          value: 'Sim',
                          groupValue: _selectedCentralAccess,
                          onChanged: (value) {
                            setState(() {
                              _selectedCentralAccess = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Não'),
                          value: 'Não',
                          groupValue: _selectedCentralAccess,
                          onChanged: (value) {
                            setState(() {
                              _selectedCentralAccess = value;
                            });
                          },
                        ),
                      ),
                    ]),
                  ),
                  if (_selectedCentralAccess == 'Sim')
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Profissional',
                          ),
                        ),
                        spacingRow,
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Horário',
                          ),
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
                        child: RadioListTile<String>(
                          title: const Text('Sim'),
                          value: 'Sim',
                          groupValue: _selectedPeripheralAccess,
                          onChanged: (value) {
                            setState(() {
                              _selectedPeripheralAccess = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Não'),
                          value: 'Não',
                          groupValue: _selectedPeripheralAccess,
                          onChanged: (value) {
                            setState(() {
                              _selectedPeripheralAccess = value;
                            });
                          },
                        ),
                      ),
                    ]),
                  ),
                  if (_selectedPeripheralAccess == 'Sim')
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Profissional',
                          ),
                        ),
                        spacingRow,
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Horário',
                          ),
                        ),
                        spacingRow,
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Dispositivo intravenoso nº',
                          ),
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
                        child: RadioListTile<String>(
                          title: const Text('Sim'),
                          value: 'Sim',
                          groupValue: _selectedIntraosseousAccess,
                          onChanged: (value) {
                            setState(() {
                              _selectedIntraosseousAccess = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Não'),
                          value: 'Não',
                          groupValue: _selectedIntraosseousAccess,
                          onChanged: (value) {
                            setState(() {
                              _selectedIntraosseousAccess = value;
                            });
                          },
                        ),
                      ),
                    ]),
                  ),
                  if (_selectedIntraosseousAccess == 'Sim')
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Profissional',
                          ),
                        ),
                        spacingRow,
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Horário',
                          ),
                        ),
                      ]),
                    ),
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
                        child: RadioListTile<String>(
                          title: const Text('Sim'),
                          value: 'Sim',
                          groupValue: _selectedChestDrainage,
                          onChanged: (value) {
                            setState(() {
                              _selectedChestDrainage = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Não'),
                          value: 'Não',
                          groupValue: _selectedChestDrainage,
                          onChanged: (value) {
                            setState(() {
                              _selectedChestDrainage = value;
                            });
                          },
                        ),
                      ),
                    ]),
                  ),
                  if (_selectedChestDrainage == 'Sim')
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Nº',
                              ),
                            ),
                          ),
                          spacingColumn,
                          Expanded(
                              child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Horário',
                            ),
                          ))
                        ]),
                        spacingRow,
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Profissional',
                          ),
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
                            decoration:
                                InputDecoration(labelText: 'Catéter gástrico'),
                            items: const [
                              DropdownMenuItem(
                                value: 'Nasogástrico',
                                child: Text('Nasogástrico'),
                              ),
                              DropdownMenuItem(
                                value: 'Orogástrico',
                                child: Text('Orogástrico'),
                              ),
                              DropdownMenuItem(
                                value: 'Enteral',
                                child: Text('Entera'),
                              ),
                              DropdownMenuItem(
                                value: 'Não',
                                child: Text('Não'),
                              )
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedGastricCatheter = value as String?;
                              });
                            },
                          ),
                          spacingRow,
                          if (_selectedGastricCatheter != 'Não') ...[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Profissional',
                              ),
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
                          child: RadioListTile<String>(
                            title: const Text('Sim'),
                            value: 'Sim',
                            groupValue: _selectedBladderCatheter,
                            onChanged: (value) {
                              setState(() {
                                _selectedBladderCatheter = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Não'),
                            value: 'Não',
                            groupValue: _selectedBladderCatheter,
                            onChanged: (value) {
                              setState(() {
                                _selectedBladderCatheter = value;
                              });
                            },
                          ),
                        ),
                      ]),
                      if (_selectedBladderCatheter == 'Sim') ...[
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Tamanho',
                              ),
                            )),
                            spacingColumn,
                            Expanded(
                                child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Horário',
                              ),
                            ))
                          ],
                        ),
                        spacingRow,
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Profissional',
                          ),
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
                          child: RadioListTile<String>(
                            title: const Text('Sim'),
                            value: 'Sim',
                            groupValue: _selectedPCR,
                            onChanged: (value) {
                              setState(() {
                                _selectedPCR = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Não'),
                            value: 'Não',
                            groupValue: _selectedPCR,
                            onChanged: (value) {
                              setState(() {
                                _selectedPCR = value;
                              });
                            },
                          ),
                        ),
                      ]),
                      if (_selectedPCR == 'Sim') ...[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Ciclos',
                          ),
                        ),
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
                              child: RadioListTile<String>(
                                title: const Text('Sim'),
                                value: 'Sim',
                                groupValue: _selectedPCRMedicine,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPCRMedicine = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('Não'),
                                value: 'Não',
                                groupValue: _selectedPCRMedicine,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPCRMedicine = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        if (_selectedPCRMedicine == 'Sim') ...[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Quais e doses',
                            ),
                          ),
                          spacingRow,
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Horários das medicações',
                            ),
                          ),
                        ],
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
                              child: RadioListTile<String>(
                                title: const Text('Sim'),
                                value: 'Sim',
                                groupValue:
                                    _selectedCardioversionDesgibrillation,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCardioversionDesgibrillation =
                                        value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('Não'),
                                value: 'Não',
                                groupValue:
                                    _selectedCardioversionDesgibrillation,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCardioversionDesgibrillation =
                                        value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
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
                            child: RadioListTile<String>(
                              title: const Text('Sim'),
                              value: 'Sim',
                              groupValue: _selectedECG,
                              onChanged: (value) {
                                setState(() {
                                  _selectedECG = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Não'),
                              value: 'Não',
                              groupValue: _selectedECG,
                              onChanged: (value) {
                                setState(() {
                                  _selectedECG = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      if (_selectedECG == 'Sim') ...[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Alteração',
                          ),
                        ),
                        spacingRow,
                      ]
                    ]),
                  ),
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
                      decoration: InputDecoration(
                        labelText:
                            'Outras anotações gerais referente a avaliação',
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
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
