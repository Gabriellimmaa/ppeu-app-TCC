import 'package:flutter/material.dart';
import 'package:ppeu/core/notifier/database.notifier.dart';
import 'package:ppeu/core/notifier/hospitalUnit.notifier.dart';
import 'package:ppeu/core/notifier/mobileUnit.notifier.dart';
import 'package:ppeu/models/HospitalUnit.model.dart';
import 'package:ppeu/models/MobileUnit.model.dart';
import 'package:ppeu/models/PP.model.dart';
import 'package:ppeu/screens/Report/widgets/GraphEncRecep.widget.dart';
import 'package:ppeu/screens/Report/widgets/GraphStatusClinica.widget.dart';
import 'package:ppeu/screens/Report/widgets/GraphUMUH.widget.dart';
import 'package:ppeu/screens/Report/widgets/ModalReportFilters.widget.dart';
import 'package:provider/provider.dart';

class ReportGraphs extends StatefulWidget {
  final ReportFilters? filter;
  const ReportGraphs({Key? key, required this.filter}) : super(key: key);

  @override
  State<ReportGraphs> createState() => _ReportGraphsState();
}

class _ReportGraphsState extends State<ReportGraphs> {
  bool isLoading = true;
  String selected = 'UM/UH';
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
  void didUpdateWidget(ReportGraphs oldWidget) {
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
                value: 'UM/UH',
                child: Text('Unidade Móvel / Unidade Hospitalar'),
              ),
              DropdownMenuItem(
                value: 'Enc/Recep',
                child: Text('PPs Enc./Recep.'),
              ),
              DropdownMenuItem(
                value: 'Status/Clinica',
                child: Text('Status / Cínica'),
              ),
            ],
          ),
        ),
        Expanded(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : selected == 'UM/UH'
                  ? ReportGraphUMUH(
                      hospitalData: hospitalData,
                      mobileData: mobileData,
                      data: data,
                    )
                  : selected == 'Status/Clinica'
                      ? ReportGraphStatusClinica(
                          data: data,
                        )
                      : selected == 'Enc/Recep'
                          ? ReportGraphEncRecep(
                              data: data,
                              mobileData: mobileData,
                              hospitalData: hospitalData,
                            )
                          : Container(),
        )
      ],
    );
  }
}
