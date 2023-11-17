import 'package:flutter/material.dart';
import 'package:ppue/core/notifier/database.notifier.dart';
import 'package:ppue/core/notifier/hospitalUnit.notifier.dart';
import 'package:ppue/core/notifier/mobileUnit.notifier.dart';
import 'package:ppue/models/HospitalUnit.model.dart';
import 'package:ppue/models/MobileUnit.model.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:ppue/screens/Report/widgets/ModalReportFilters.widget.dart';
import 'package:ppue/screens/Report/widgets/TableISBAR.widget.dart';
import 'package:ppue/screens/Report/widgets/TableSTATUS.widget.dart';
import 'package:ppue/screens/Report/widgets/TableUH.widget.dart';
import 'package:ppue/screens/Report/widgets/TableUM.widget.dart';
import 'package:provider/provider.dart';

class TableNumeric extends StatefulWidget {
  final ReportFilters? filter;
  const TableNumeric({Key? key, required this.filter}) : super(key: key);

  @override
  TableNumericState createState() => TableNumericState();
}

class TableNumericState extends State<TableNumeric> {
  bool isLoading = true;
  String selected = 'UM';
  List<PPModel> data = [];
  List<HospitalUnitModel> hospitalData = [];
  List<MobileUnitModel> mobileData = [];

  Future<void> fetchData(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    DatabaseNotifier databasePP =
        Provider.of<DatabaseNotifier>(context, listen: false);
    HospitalUnitNotifier hospitalUnit =
        Provider.of<HospitalUnitNotifier>(context, listen: false);
    MobileUnitNotifier mobileUnit =
        Provider.of<MobileUnitNotifier>(context, listen: false);
    var responseHospitalUnit = await hospitalUnit.fetchAll();
    var responseMobileUnit = await mobileUnit.fetchAll();
    var responsePP = await databasePP.filterPP(
      startDate: widget.filter?.startDate ??
          DateTime.now().subtract(Duration(days: 10)),
      endDate: widget.filter?.endDate ?? DateTime.now().add(Duration(days: 1)),
    );

    setState(() {
      data = responsePP;
      hospitalData = responseHospitalUnit;
      mobileData = responseMobileUnit;
      isLoading = false;
    });
  }

  @override
  void didUpdateWidget(TableNumeric oldWidget) {
    if (widget.filter != oldWidget.filter) {
      fetchData(context);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    fetchData(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: DropdownButton(
            isExpanded: true,
            value: selected,
            onChanged: (value) {
              setState(() {
                selected = value.toString();
              });
            },
            items: const [
              DropdownMenuItem(
                value: 'UM',
                child: Text('Unidade Móvel'),
              ),
              DropdownMenuItem(
                value: 'UH',
                child: Text('Unidade Hospitalar'),
              ),
              DropdownMenuItem(
                value: 'status',
                child: Text('Status'),
              ),
              DropdownMenuItem(
                value: 'ISBAR',
                child: Text('Clínica ISBAR'),
              ),
            ],
          ),
        ),
        Expanded(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : data.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Nenhum resultado encontrado.",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Por favor, reveja e ajuste seus critérios de busca.",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  : selected == 'UM'
                      ? TableUM(
                          data: data,
                          mobileData: mobileData,
                        )
                      : selected == 'UH'
                          ? TableUH(
                              data: data,
                              hospitalData: hospitalData,
                            )
                          : selected == 'status'
                              ? TableStatus(
                                  data: data,
                                )
                              : selected == 'ISBAR'
                                  ? TableISBAR(
                                      data: data,
                                    )
                                  : Container(),
        )
      ],
    );
  }
}
