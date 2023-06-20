import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:ppue/screens/Report/widgets/Graphs.widget.dart';
import 'package:ppue/screens/Report/widgets/ListNominal.widget.dart';
import 'package:ppue/screens/Report/widgets/ModalReportFilters.widget.dart';
import 'package:ppue/screens/Report/widgets/TableNumeric.widget.dart';
import 'package:ppue/screens/SearchPP/SearchPP_List.screen.dart';
import 'package:ppue/utils/formater/DateFormatter.util.dart';
import 'package:ppue/widgets/GradientContainer.widget.dart';
import 'package:ppue/widgets/inputs/DatePickerTextField.widget.dart';
import 'package:ppue/widgets/inputs/DropdownTextField.widget.dart';

import '../ViewPP.screen.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTime selectedDate = DateTime.now();
  String? _selectedItem;
  String buttonText = 'Selecione';
  final TextEditingController _dateController = TextEditingController();
  int _selectedButtonIndex = 0;
  final List<PPModel> items = [
    examplePP,
    examplePP,
    examplePP,
    examplePP,
    examplePP,
    examplePP,
    examplePP
  ];

  int _currentSegment = 0;

  final List<bool> _selectedFruits = <bool>[true, false, false];

  bool vertical = false;
  List<Widget> fruits = <Widget>[Text('Apple'), Text('Banana'), Text('Orange')];

  final _dateStartController = TextEditingController();
  final _dateEndController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RELATÓRIOS',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: gradientContainer(
          child: Column(
            children: [
              SizedBox(height: 70),
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 16,
                ),
                child: Row(children: [
                  Expanded(
                    child: DatePickerTextField(
                      controller: _dateStartController,
                      decoration: InputDecoration(
                        labelText: 'Data Inicial',
                        labelStyle: TextStyle(color: Colors.grey[800]),
                        suffixIcon: Icon(Icons.calendar_today),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: DatePickerTextField(
                      controller: _dateEndController,
                      decoration: InputDecoration(
                        labelText: 'Data Final',
                        labelStyle: TextStyle(color: Colors.grey[800]),
                        suffixIcon: Icon(Icons.calendar_today),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => ModalReportFilters(
                                onChanged: (p0) => print(p0),
                              ));
                    },
                    icon: Icon(
                      Icons.filter_alt,
                      color: Colors.white.withOpacity(0.5),
                      size: 34,
                    ),
                  )
                ]),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedButtonIndex = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedButtonIndex == 0
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 10.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Nominal',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedButtonIndex = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedButtonIndex == 1
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 10.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Numérico',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedButtonIndex = 2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedButtonIndex == 2
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 10.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Gráficos',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1),
              Expanded(
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: _selectedButtonIndex == 0
                      ? ListNominal(
                          items: items,
                        )
                      : _selectedButtonIndex == 1
                          ? TableNumeric()
                          : ReportGraphs(),
                ),
              ),
            ],
          ),
        ));
  }
}
