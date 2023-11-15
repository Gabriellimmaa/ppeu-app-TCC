// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/core/notifier/database.notifier.dart';
import 'package:ppue/core/notifier/hospitalUnit.notifier.dart';
import 'package:ppue/core/notifier/user.notifier.dart';
import 'package:ppue/screens/SearchPP/SearchPP_List.screen.dart';
import 'package:ppue/utils/formater/LimitCharacters.util.dart';
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
  List<DropdownMenuItem<String>> _hospitalUnitDropdownItems = [];
  List<DropdownMenuItem<String>> _usersDropdownItems = [];

  @override
  void dispose() {
    _dateController.dispose();
    _nameController.dispose();
    super.dispose();
  }

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

  Future<void> fetchHospitalUnitsAndBuildDropdown(BuildContext context) async {
    HospitalUnitNotifier hospitalUnitNotifier =
        Provider.of<HospitalUnitNotifier>(context, listen: false);
    List<dynamic> data = await hospitalUnitNotifier.fetchAll();
    _hospitalUnitDropdownItems = data.map((element) {
      return DropdownMenuItem<String>(
        value: '${element.id.toString()}::${element.name}::${element.surname}',
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
        value: element.taxId.toString(),
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
    fetchHospitalUnitsAndBuildDropdown(context);
    fetchUsersAndBuildDropdown(context);
  }

  Widget buildForm() {
    DatabaseNotifier databaseNotifier =
        Provider.of<DatabaseNotifier>(context, listen: false);
    UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);

    void updateUsersDropdown(id) async {
      List<dynamic> data = await userNotifier.filterByHospitalUnit(id: id);

      setState(() {
        _usersDropdownItems = data.map((element) {
          return DropdownMenuItem<String>(
            value: element.taxId,
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

    void checkValidFields() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.validate();
      }
    }

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
                    items: _hospitalUnitDropdownItems,
                    onChanged: (value) {
                      updateUsersDropdown(int.parse(
                          value.toString().split('::')[0].toString()));
                      setState(() {
                        _selectedHospital = value as String?;
                      });
                      checkValidFields();
                    },
                    validator: FormValidators.required,
                  ),
                  spacingRow,
                  DropdownButtonFormField(
                    value: _selectedResponsavel,
                    decoration: InputDecoration(labelText: 'Responsável'),
                    items: _usersDropdownItems,
                    onChanged: (value) => {
                      setState(() {
                        _selectedResponsavel = value.toString();
                      }),
                      checkValidFields(),
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
                          encaminhamento: _selectedHospital!.split('::')[1],
                          date: _dateController.text
                              .split('/')
                              .reversed
                              .join('-')
                              .toString(),
                        );

                        if (response.isEmpty) {
                          Navigator.pop(context); // Fecha o diálogo de loading
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Nenhuma PP encontrada'),
                                content: Text(
                                    'Não foi encontrado nenhuma passagem de plantão com os dados informados.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          Navigator.pop(context); // Fecha o diálogo de loading

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchPPListScreen(
                                  ppModels: response,
                                  hospitalUnit:
                                      _selectedHospital!.split('::')[2]),
                            ),
                          );
                        }
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
