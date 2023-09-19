// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/core/notifier/database.notifier.dart';
import 'package:ppue/screens/SearchPP/SearchPP_List.screen.dart';
import 'package:ppue/utils/validation/FormValidators.validation.dart';
import 'package:ppue/widgets/CustomPageContainer.widget.dart';
import 'package:ppue/widgets/CustomScaffold.widget.dart';
import 'package:ppue/widgets/GradientButton.widget.dart';
import 'package:ppue/widgets/inputs/DatePickerTextField.widget.dart';
import 'package:provider/provider.dart';

class SearchPPScreen extends StatefulWidget {
  const SearchPPScreen({Key? key}) : super(key: key);

  @override
  State<SearchPPScreen> createState() => _SearchPPScreenState();
}

class _SearchPPScreenState extends State<SearchPPScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String? _selectedHospital;
  String? _selectedResponsavel;
  String buttonText = 'Selecione';
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text('Localizar PPs'),
        centerTitle: true,
      ),
      body: CustomPageContainer(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return constraints.maxHeight >= MediaQuery.of(context).size.height
              ? SingleChildScrollView(
                  child: buildForm(),
                )
              : buildForm();
        },
      )),
    );
  }

  Widget buildForm() {
    DatabaseNotifier databaseNotifier =
        Provider.of<DatabaseNotifier>(context, listen: false);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 25),
                  DropdownButtonFormField(
                    value: _selectedHospital,
                    decoration:
                        InputDecoration(labelText: 'Unidade hospitalar'),
                    items: const [
                      DropdownMenuItem(
                          value: 'Hospital do Trabalhador',
                          child: Text('HU',
                              style: TextStyle(
                                color: Colors.black,
                              ))),
                      DropdownMenuItem(
                          value: 'HZN',
                          child: Text('HZN',
                              style: TextStyle(
                                color: Colors.black,
                              ))),
                      DropdownMenuItem(
                          value: 'ISCAL',
                          child: Text('ISCAL',
                              style: TextStyle(
                                color: Colors.black,
                              ))),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedHospital = value as String?;
                      });
                    },
                    validator: FormValidators.required,
                  ),
                  spacingRow,
                  DropdownButtonFormField(
                    value: _selectedResponsavel,
                    decoration: InputDecoration(labelText: 'Responsável'),
                    items: const [
                      DropdownMenuItem(
                          value: '48052317851', child: Text('Gabriel Lima')),
                      DropdownMenuItem(
                          value: 'andre', child: Text('Andre Menolli'))
                    ],
                    onChanged: (value) => {
                      setState(() {
                        _selectedResponsavel = value.toString();
                      })
                    },
                    validator: FormValidators.required,
                  ),
                  spacingRow,
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome do paciente',
                      suffixIcon: Icon(Icons.person),
                    ),
                    validator: FormValidators.required,
                  ),
                  spacingRow,
                  DatePickerTextField(
                    controller: _dateController,
                  ),
                ],
              ),
            ),
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  text: 'Pesquisar',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        barrierDismissible: false,
                      );

                      try {
                        var response = await databaseNotifier.filterPP(
                          nome: _nameController.text,
                          responsavelRecebimentoCpf: _selectedResponsavel!,
                          encaminhamento: _selectedHospital!,
                        );

                        Navigator.pop(context); // Fecha o diálogo de loading

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchPPListScreen(ppModels: response),
                          ),
                        );
                      } catch (e) {
                        Navigator.pop(
                            context); // Fecha o diálogo de loading em caso de erro
                        print(e.toString());
                      }
                      return;
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
