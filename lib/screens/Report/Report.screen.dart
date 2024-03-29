import 'package:flutter/material.dart';
import 'package:ppeu/core/notifier/authentication.notifier.dart';
import 'package:ppeu/screens/Report/widgets/Graphs.widget.dart';
import 'package:ppeu/screens/Report/widgets/Nominal.widget.dart';
import 'package:ppeu/screens/Report/widgets/ModalReportFilters.widget.dart';
import 'package:ppeu/screens/Report/widgets/TableNumeric.widget.dart';
import 'package:ppeu/widgets/GradientContainer.widget.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool isLoading = true;
  DateTime selectedDate = DateTime.now();
  ReportFilters? _selectedFilters;
  String buttonText = 'Selecione';
  int _selectedButtonIndex = 0;

  Future<void> setInitialFilters(BuildContext context) async {
    AuthenticationNotifier authentication =
        Provider.of<AuthenticationNotifier>(context, listen: false);

    setState(() {
      _selectedFilters = ReportFilters(
        endDate: null,
        startDate: null,
        mobileUnit: authentication.mobileUnit?.name,
        status: null,
        hospitalUnit: authentication.hospitalUnit?.id,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    setInitialFilters(context);
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationNotifier authentication =
        Provider.of<AuthenticationNotifier>(context, listen: false);
    double appBarHeight =
        MediaQuery.of(context).padding.top + AppBar().preferredSize.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'RELATÓRIOS',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => ModalReportFilters(
                      indexPage: _selectedButtonIndex,
                      filters: _selectedFilters,
                      onSubmit: (p0) => {
                        setState(() {
                          _selectedFilters = p0;
                        }),
                      },
                    ),
                  );
                },
                icon: Icon(
                  Icons.filter_alt,
                  color: Colors.white.withOpacity(0.5),
                  size: 34,
                ),
              ),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: gradientContainer(
          child: Column(
            children: [
              SizedBox(height: appBarHeight),
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
                      ? Nominal(
                          filter: _selectedFilters,
                          authentication: authentication,
                        )
                      : _selectedButtonIndex == 1
                          ? TableNumeric(
                              filter: _selectedFilters,
                            )
                          : ReportGraphs(
                              filter: _selectedFilters,
                            ),
                ),
              ),
            ],
          ),
        ));
  }
}
