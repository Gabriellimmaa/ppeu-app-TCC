import 'package:flutter/material.dart';

class NewPP_B extends StatefulWidget {
  const NewPP_B({Key? key}) : super(key: key);

  @override
  State<NewPP_B> createState() => _NewPP_BState();
}

class _NewPP_BState extends State<NewPP_B> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedAllergies;
  String? _selectedComorbidity;
  String? _selectedVices;
  String? _selectedMedicationsInUse;
  String? _selectedHospitalizationHistory;
  String? _selectedPreviousSurgery;
  String? _selectedInjuries;
  String? _selectedLaboratoryAlterations;
  String? _selectedPrecautions;
  String? _selectedFast;

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
                      decoration: InputDecoration(
                        labelText: 'Breve descrição história clínica',
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
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
                      child: RadioListTile<String>(
                        title: const Text('Sim'),
                        value: 'Sim',
                        groupValue: _selectedAllergies,
                        onChanged: (value) {
                          setState(() {
                            _selectedAllergies = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Não'),
                        value: 'Não',
                        groupValue: _selectedAllergies,
                        onChanged: (value) {
                          setState(() {
                            _selectedAllergies = value;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedAllergies == 'Sim')
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Quais alergias',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
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
                      child: RadioListTile<String>(
                        title: const Text('Sim'),
                        value: 'Sim',
                        groupValue: _selectedComorbidity,
                        onChanged: (value) {
                          setState(() {
                            _selectedComorbidity = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Não'),
                        value: 'Não',
                        groupValue: _selectedComorbidity,
                        onChanged: (value) {
                          setState(() {
                            _selectedComorbidity = value;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedComorbidity == 'Sim')
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Quais comorbidades',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
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
                      child: RadioListTile<String>(
                        title: const Text('Sim'),
                        value: 'Sim',
                        groupValue: _selectedVices,
                        onChanged: (value) {
                          setState(() {
                            _selectedVices = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Não'),
                        value: 'Não',
                        groupValue: _selectedVices,
                        onChanged: (value) {
                          setState(() {
                            _selectedVices = value;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedVices == 'Sim')
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Quais vícios',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
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
                      child: RadioListTile<String>(
                        title: const Text('Sim'),
                        value: 'Sim',
                        groupValue: _selectedMedicationsInUse,
                        onChanged: (value) {
                          setState(() {
                            _selectedMedicationsInUse = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Não'),
                        value: 'Não',
                        groupValue: _selectedMedicationsInUse,
                        onChanged: (value) {
                          setState(() {
                            _selectedMedicationsInUse = value;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedMedicationsInUse == 'Sim')
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Quais medicamentos',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
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
                      child: RadioListTile<String>(
                        title: const Text('Sim'),
                        value: 'Sim',
                        groupValue: _selectedHospitalizationHistory,
                        onChanged: (value) {
                          setState(() {
                            _selectedHospitalizationHistory = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Não'),
                        value: 'Não',
                        groupValue: _selectedHospitalizationHistory,
                        onChanged: (value) {
                          setState(() {
                            _selectedHospitalizationHistory = value;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedHospitalizationHistory == 'Sim')
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Quais históricos de internações',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
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
                      child: RadioListTile<String>(
                        title: const Text('Sim'),
                        value: 'Sim',
                        groupValue: _selectedPreviousSurgery,
                        onChanged: (value) {
                          setState(() {
                            _selectedPreviousSurgery = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Não'),
                        value: 'Não',
                        groupValue: _selectedPreviousSurgery,
                        onChanged: (value) {
                          setState(() {
                            _selectedPreviousSurgery = value;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedPreviousSurgery == 'Sim')
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Quais cirurgias prévias',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
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
                      child: RadioListTile<String>(
                        title: const Text('Sim'),
                        value: 'Sim',
                        groupValue: _selectedInjuries,
                        onChanged: (value) {
                          setState(() {
                            _selectedInjuries = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Não'),
                        value: 'Não',
                        groupValue: _selectedInjuries,
                        onChanged: (value) {
                          setState(() {
                            _selectedInjuries = value;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedInjuries == 'Sim')
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Grau e local da lesão',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
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
                      child: RadioListTile<String>(
                        title: const Text('Sim'),
                        value: 'Sim',
                        groupValue: _selectedLaboratoryAlterations,
                        onChanged: (value) {
                          setState(() {
                            _selectedLaboratoryAlterations = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Não'),
                        value: 'Não',
                        groupValue: _selectedLaboratoryAlterations,
                        onChanged: (value) {
                          setState(() {
                            _selectedLaboratoryAlterations = value;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedLaboratoryAlterations == 'Sim')
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Quais alterações',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
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
                  child: Column(children: [
                    spacingRow,
                    RadioListTile<String>(
                      title: const Text('Gotículas'),
                      value: 'Gotículas',
                      groupValue: _selectedPrecautions,
                      onChanged: (value) {
                        setState(() {
                          _selectedPrecautions = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Aerossóis'),
                      value: 'Aerossóis',
                      groupValue: _selectedPrecautions,
                      onChanged: (value) {
                        setState(() {
                          _selectedPrecautions = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Contato'),
                      value: 'Contato',
                      groupValue: _selectedPrecautions,
                      onChanged: (value) {
                        setState(() {
                          _selectedPrecautions = value;
                        });
                      },
                    ),
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
                      child: RadioListTile<String>(
                        title: const Text('Sim'),
                        value: 'Sim',
                        groupValue: _selectedFast,
                        onChanged: (value) {
                          setState(() {
                            _selectedFast = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Não'),
                        value: 'Não',
                        groupValue: _selectedFast,
                        onChanged: (value) {
                          setState(() {
                            _selectedFast = value;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                if (_selectedFast == 'Sim')
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      spacingRow,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Tempo de jejum',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
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
