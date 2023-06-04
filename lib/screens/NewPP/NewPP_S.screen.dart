import 'package:flutter/material.dart';

class NewPP_S extends StatefulWidget {
  const NewPP_S({Key? key}) : super(key: key);

  @override
  State<NewPP_S> createState() => _NewPP_SState();
}

class _NewPP_SState extends State<NewPP_S> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedOrigin;
  String? _selectedTrauma;
  String? _selectedClinic;
  bool _showTransferField = false;
  bool _showTraumaField = false;
  bool _showClinicField = false;

  final spacingRow = const SizedBox(height: 16);

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
                        decoration: InputDecoration(labelText: 'Origem'),
                        items: const [
                          DropdownMenuItem(
                            value: 'Residência',
                            child: Text('Residência'),
                          ),
                          DropdownMenuItem(
                            value: 'Via pública',
                            child: Text('Via pública'),
                          ),
                          DropdownMenuItem(
                            value: 'Transferência',
                            child: Text('Transferência'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedOrigin = value as String?;
                            _showTransferField = value == 'Transferência';
                          });
                        },
                      ),
                      if (_showTransferField) ...[
                        spacingRow,
                        TextFormField(
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
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Horário (início dos sintomas)'),
                        ),
                        spacingRow,
                        DropdownButtonFormField(
                          decoration:
                              InputDecoration(labelText: 'Dor torácica'),
                          items: const [
                            DropdownMenuItem(
                              value: 'Sim',
                              child: Text('Sim'),
                            ),
                            DropdownMenuItem(
                              value: 'Não',
                              child: Text('Não'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedOrigin = value as String?;
                              _showTransferField = value == 'Transferência';
                            });
                          },
                        ),
                        spacingRow,
                        DropdownButtonFormField(
                          decoration:
                              InputDecoration(labelText: 'Déficit motor'),
                          items: const [
                            DropdownMenuItem(
                              value: 'Sim',
                              child: Text('Sim'),
                            ),
                            DropdownMenuItem(
                              value: 'Não',
                              child: Text('Não'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedOrigin = value as String?;
                              _showTransferField = value == 'Transferência';
                            });
                          },
                        ),
                        spacingRow,
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Local (se for o caso)'),
                        ),
                        spacingRow,
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Outros (se for o caso)'),
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
                            decoration: InputDecoration(labelText: 'Selecione'),
                            items: const [
                              DropdownMenuItem(
                                value: 'Abdominal',
                                child: Text('Abdominal'),
                              ),
                              DropdownMenuItem(
                                value: 'Cardíaco',
                                child: Text('Cardíaco'),
                              ),
                              DropdownMenuItem(
                                value: 'Metabólico',
                                child: Text('Metabólico'),
                              ),
                              DropdownMenuItem(
                                value: 'Neurológico',
                                child: Text('Neurológico'),
                              ),
                              DropdownMenuItem(
                                value: 'Pulmonar/respiratório',
                                child: Text('Pulmonar/respiratório'),
                              ),
                              DropdownMenuItem(
                                value: 'Outros',
                                child: Text('Outros'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedClinic = value as String?;
                                _showClinicField = value == 'Outros';
                              });
                            },
                          ),
                          if (_showClinicField) ...[
                            spacingRow,
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Complemento'),
                            )
                          ],
                          spacingRow,
                        ],
                      )),
                  Text(
                    'TRAUMA',
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
                                InputDecoration(labelText: 'Tipo de trauma'),
                            items: const [
                              DropdownMenuItem(
                                value: 'Acidente de trânsito',
                                child: Text('Acidente de trânsito'),
                              ),
                              DropdownMenuItem(
                                value: 'Agressão',
                                child: Text('Agressão'),
                              ),
                              DropdownMenuItem(
                                value: 'FAB/FAF',
                                child: Text('FAB/FAF'),
                              ),
                              DropdownMenuItem(
                                value: 'Intoxicção',
                                child: Text('Intoxicção'),
                              ),
                              DropdownMenuItem(
                                value: 'Queda',
                                child: Text('Queda'),
                              ),
                              DropdownMenuItem(
                                value: 'Queimadura',
                                child: Text('Queimadura'),
                              ),
                              DropdownMenuItem(
                                value: 'Outros',
                                child: Text('Outros'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedTrauma = value as String?;
                                _showTraumaField =
                                    value == 'Outros' || value == 'Queimadura';
                              });
                            },
                          ),
                          if (_showTraumaField) ...[
                            spacingRow,
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: _selectedTrauma == 'Outros'
                                      ? 'Complemento'
                                      : '% de superfície corporal queimada'),
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
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          spacingRow,
                          DropdownButtonFormField(
                            decoration:
                                InputDecoration(labelText: 'Tipo de gestação'),
                            items: const [
                              DropdownMenuItem(
                                value: 'Primigesta',
                                child: Text('Primigesta'),
                              ),
                              DropdownMenuItem(
                                value: 'Multigesta',
                                child: Text('Multigesta'),
                              )
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedTrauma = value as String?;
                                _showTraumaField =
                                    value == 'Outros' || value == 'Queimadura';
                              });
                            },
                          ),
                          spacingRow,
                          DropdownButtonFormField(
                            decoration: InputDecoration(labelText: 'Perdas VW'),
                            items: const [
                              DropdownMenuItem(
                                value: 'Sim',
                                child: Text('Sim'),
                              ),
                              DropdownMenuItem(
                                value: 'Não',
                                child: Text('Não'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedOrigin = value as String?;
                                _showTransferField = value == 'Transferência';
                              });
                            },
                          ),
                          spacingRow,
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Idade Gestional (IG)'),
                            keyboardType: TextInputType.number,
                          ),
                          spacingRow,
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Batimentos cardíacos fetais (BCF)'),
                            keyboardType: TextInputType.number,
                          ),
                          spacingRow,
                        ],
                      )),
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
                      decoration: InputDecoration(labelText: 'Preencher'),
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
