// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:ppeu/constants/constants.dart';
import 'package:ppeu/core/notifier/authentication.notifier.dart';
import 'package:ppeu/models/HospitalUnit.model.dart';
import 'package:ppeu/models/MobileUnit.model.dart';
import 'package:ppeu/widgets/CustomPageContainer.widget.dart';
import 'package:ppeu/widgets/CustomScaffold.widget.dart';
import 'package:ppeu/widgets/GradientButton.widget.dart';
import 'package:provider/provider.dart';

class SelectUserScreen extends StatefulWidget {
  const SelectUserScreen({Key? key}) : super(key: key);

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  bool isLoading = true;
  String selectedMobileUnit = '';

  final List<DropdownMenuItem<String>> _hospitalUnitData = [
    DropdownMenuItem(
      value: '',
      child: Text('Selecione'),
    )
  ];
  final List<DropdownMenuItem<String>> _mobileUnitData = [
    DropdownMenuItem(
      value: '',
      child: Text('Selecione'),
    )
  ];

  Future<void> fetchMobileUnits(BuildContext context) async {
    AuthenticationNotifier authenticationNotifier =
        Provider.of<AuthenticationNotifier>(
      context,
      listen: false,
    );

    setState(() {
      if (authenticationNotifier.hospitalUnits != null) {
        for (var element in authenticationNotifier.hospitalUnits!) {
          _hospitalUnitData.add(DropdownMenuItem(
            value: element.toJsonString(),
            child: Text(element.name.toString()),
          ));
        }
      }
      if (authenticationNotifier.mobileUnits != null) {
        for (var element in authenticationNotifier.mobileUnits!) {
          _mobileUnitData.add(DropdownMenuItem(
            value: element.toJsonString(),
            child: Text(element.name.toString()),
          ));
        }
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMobileUnits(context);
  }

  @override
  Widget build(BuildContext context) {
    bool hasMobileUnit = _mobileUnitData.length > 1;

    AuthenticationNotifier authenticationNotifier =
        Provider.of<AuthenticationNotifier>(
      context,
      listen: false,
    );
    AuthenticationNotifier userNotifier = Provider.of<AuthenticationNotifier>(
      context,
      listen: false,
    );

    return CustomScaffold(
        appBar: AppBar(
          title: Text('PPEU'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                authenticationNotifier.logout(context: context);
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Image.asset('assets/images/logo2.png',
                  height: 200, width: 200),
            ),
            spacingRow,
            Expanded(
                child: CustomPageContainer(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                          Column(
                            children: [
                              Text(hasMobileUnit
                                  ? 'Unidade Móvel'
                                  : 'Unidade Hospitalar'),
                              SizedBox(
                                height: 10,
                              ),
                              DropdownButton(
                                  value: selectedMobileUnit,
                                  items: hasMobileUnit
                                      ? _mobileUnitData
                                      : _hospitalUnitData,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedMobileUnit = value as String;
                                    });
                                  }),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: GradientButton(
                                      onPressed: () {
                                        if (selectedMobileUnit == '') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Selecione uma unidade ${hasMobileUnit ? "móvel" : "hospitalar"}',
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }
                                        if (hasMobileUnit) {
                                          MobileUnitModel mobileUnit =
                                              MobileUnitModel.fromJsonString(
                                                  selectedMobileUnit);
                                          userNotifier.setUser(
                                              type: UserType.MOBILE_UNIT,
                                              mobileUnit: mobileUnit,
                                              context: context);
                                        } else {
                                          HospitalUnitModel hospitalUnit =
                                              HospitalUnitModel.fromJsonString(
                                                  selectedMobileUnit);
                                          userNotifier.setUser(
                                              type: UserType.HOSPITAL_UNIT,
                                              hospitalUnit: hospitalUnit,
                                              context: context);
                                        }
                                      },
                                      text:
                                          'Entrar como unidade ${hasMobileUnit ? "móvel" : "hospitalar"}',
                                    ),
                                  ),
                                ],
                              ))
                        ]),
            ))
          ],
        ));
  }
}
