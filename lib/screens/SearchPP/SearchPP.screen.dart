// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:ppeu/constants/constants.dart';
import 'package:ppeu/core/notifier/authentication.notifier.dart';
import 'package:ppeu/core/notifier/database.notifier.dart';
import 'package:ppeu/core/notifier/hospitalUnit.notifier.dart';
import 'package:ppeu/core/notifier/mobileUnit.notifier.dart';
import 'package:ppeu/core/notifier/user.notifier.dart';
import 'package:ppeu/models/HospitalUnit.model.dart';
import 'package:ppeu/models/MobileUnit.model.dart';
import 'package:ppeu/screens/SearchPP/SearchPP_List.screen.dart';
import 'package:ppeu/utils/formater/LimitCharacters.util.dart';
import 'package:ppeu/widgets/CustomPageContainer.widget.dart';
import 'package:ppeu/widgets/CustomScaffold.widget.dart';
import 'package:ppeu/widgets/GradientButton.widget.dart';
import 'package:ppeu/widgets/inputs/DatePickerTextField.widget.dart';
import 'package:provider/provider.dart';

class SearchPPScreen extends StatefulWidget {
  final HospitalUnitModel? hospitalUnit;
  final MobileUnitModel? mobileUnit;
  const SearchPPScreen({Key? key, this.hospitalUnit, this.mobileUnit})
      : super(key: key);

  @override
  State<SearchPPScreen> createState() => _SearchPPScreenState();
}

class _SearchPPScreenState extends State<SearchPPScreen> {
  bool isLoading = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  int? _selectedHospitalUnit;
  String? _selectedMobileUnit;
  String? _selectedResponsavel;
  String buttonText = 'Selecione';
  DateTime? _selectedDate;
  final TextEditingController _nameController = TextEditingController();
  List<DropdownMenuItem<int>> _hospitalUnitDropdownItems = [];
  List<DropdownMenuItem<String>> _mobileUnitDropdownItems = [];
  List<DropdownMenuItem<String>> _usersDropdownItems = [];

  @override
  void dispose() {
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
    AuthenticationNotifier user =
        Provider.of<AuthenticationNotifier>(context, listen: false);
    HospitalUnitNotifier hospitalUnitNotifier =
        Provider.of<HospitalUnitNotifier>(context, listen: false);
    var data = await hospitalUnitNotifier.fetchAll();

    setState(() {
      _hospitalUnitDropdownItems = data.map((element) {
        return DropdownMenuItem<int>(
          value: element.id,
          child: Text(
            limitCharacters(element.name, 30),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        );
      }).toList();
      if (user.hospitalUnit != null) {
        print(user.hospitalUnit!.toJsonString());
        _selectedHospitalUnit = user.hospitalUnit!.id;
      }
    });
  }

  Future<void> fetchMobileUnitsAndBuildDropdown(BuildContext context) async {
    AuthenticationNotifier user =
        Provider.of<AuthenticationNotifier>(context, listen: false);
    MobileUnitNotifier mobileUnitNotifier =
        Provider.of<MobileUnitNotifier>(context, listen: false);
    var data = await mobileUnitNotifier.fetchAll();

    setState(() {
      _mobileUnitDropdownItems = data.map((element) {
        return DropdownMenuItem<String>(
          value: element.name,
          child: Text(
            limitCharacters(element.name, 30),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        );
      }).toList();
      if (user.mobileUnit != null) {
        _selectedMobileUnit = user.mobileUnit!.name;
      }
    });
  }

  Future<void> fetchUsersAndBuildDropdown(BuildContext context) async {
    UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);

    int? id = (widget.hospitalUnit != null
        ? widget.hospitalUnit!.id
        : _selectedHospitalUnit);

    if (id != null) {
      List<dynamic> data = await userNotifier.filterByHospitalUnit(id: id);
      setState(() {
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
      });
    } else {
      List<dynamic> data = await userNotifier.fetchAll();
      setState(() {
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
      });
    }

    setState(() {
      isLoading = false;
    }); // Força o rebuild do widget
  }

  @override
  void initState() {
    super.initState();

    fetchHospitalUnitsAndBuildDropdown(context);
    fetchMobileUnitsAndBuildDropdown(context);
    fetchUsersAndBuildDropdown(context);
  }

  Widget buildForm() {
    DatabaseNotifier databaseNotifier =
        Provider.of<DatabaseNotifier>(context, listen: false);
    UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);
    AuthenticationNotifier authNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: false);

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
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        SizedBox(height: 25),
                        DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                                labelText: 'Unidade hospitalar'),
                            items: _hospitalUnitDropdownItems,
                            value: _selectedHospitalUnit,
                            onChanged: authNotifier.hospitalUnit != null
                                ? null
                                : (value) {
                                    updateUsersDropdown(value);
                                    setState(() {
                                      _selectedHospitalUnit = value;
                                    });
                                    checkValidFields();
                                  }),
                        spacingRow,
                        DropdownButtonFormField<String>(
                          decoration:
                              InputDecoration(labelText: 'Unidade móvel'),
                          items: _mobileUnitDropdownItems,
                          value: _selectedMobileUnit,
                          onChanged: authNotifier.mobileUnit != null
                              ? null
                              : (value) {
                                  setState(() {
                                    _selectedMobileUnit = value;
                                  });
                                  checkValidFields();
                                },
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
                          // validator: FormValidators.required,
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
                          value: _selectedDate,
                          onChanged: (value) {
                            setState(() {
                              _selectedDate = value;
                            });
                          },
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
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
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
                                  responsavelRecebimentoCpf:
                                      _selectedResponsavel,
                                  hospitalUnit: _selectedHospitalUnit,
                                  mobileUnit: _selectedMobileUnit,
                                  startDate: _selectedDate,
                                  endDate:
                                      _selectedDate?.add(Duration(days: 1)),
                                );

                                if (response.isEmpty) {
                                  Navigator.pop(
                                      context); // Fecha o diálogo de loading
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
                                  Navigator.pop(
                                      context); // Fecha o diálogo de loading

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchPPListScreen(
                                          ppModels: response,
                                          hospitalUnit:
                                              widget.hospitalUnit?.surname ??
                                                  ''),
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
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
