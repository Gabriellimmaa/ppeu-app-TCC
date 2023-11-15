import 'package:flutter/material.dart';
import 'package:ppue/core/notifier/database.notifier.dart';
import 'package:ppue/core/notifier/hospitalUnit.notifier.dart';
import 'package:ppue/core/notifier/mobileUnit.notifier.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportGraphUMUH extends StatefulWidget {
  const ReportGraphUMUH({Key? key}) : super(key: key);

  @override
  State<ReportGraphUMUH> createState() => _ReportGraphUMUHState();
}

class _ReportGraphUMUHState extends State<ReportGraphUMUH> {
  List<_PieData> _hospitalUnitGraph = [];
  List<_PieData> _mobileUnitGraph = [];
  int _amountPP = 0;

  Future<void> fetchHospitalUnits(BuildContext context) async {
    HospitalUnitNotifier hospitalUnitNotifier =
        Provider.of<HospitalUnitNotifier>(context, listen: false);
    List<dynamic> data = await hospitalUnitNotifier.fetchAll();
    _hospitalUnitGraph = data.map((element) {
      return _PieData(
          element.surname, element.amount, element.surname.toString());
    }).toList();
    setState(() {}); // Força o rebuild do widget
  }

  Future<void> fetchMobileUnits(BuildContext context) async {
    MobileUnitNotifier mobileUnitNotifier =
        Provider.of<MobileUnitNotifier>(context, listen: false);
    List<dynamic> data = await mobileUnitNotifier.fetchAll();
    _mobileUnitGraph = data.map((element) {
      return _PieData(element.name, element.amount, element.name.toString());
    }).toList();
    setState(() {}); //
  }

  Future<void> fetchCountAllPP(BuildContext context) async {
    DatabaseNotifier database =
        Provider.of<DatabaseNotifier>(context, listen: false);
    int data = await database.fetchCountAll();
    _amountPP = data;
    setState(() {}); //
  }

  @override
  void initState() {
    super.initState();
    fetchMobileUnits(context);
    fetchHospitalUnits(context);
    fetchCountAllPP(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            SfCircularChart(
              title: ChartTitle(
                  text: 'Unidade móvel encaminhadora',
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              palette: const [
                Colors.blue,
                Colors.orange,
                Colors.grey,
              ],
              series: <DoughnutSeries<_PieData, String>>[
                DoughnutSeries<_PieData, String>(
                    dataSource: _mobileUnitGraph,
                    explodeIndex: 0,
                    xValueMapper: (_PieData data, _) => data.xData,
                    yValueMapper: (_PieData data, _) => data.yData,
                    dataLabelMapper: (_PieData data, _) =>
                        '${data.text}\n${data.yData}%',
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
              ],
              tooltipBehavior: TooltipBehavior(
                enable: true,
                format: 'point.x : point.y%',
              ),
            ),
            SfCircularChart(
              title: ChartTitle(
                  text: 'Unidade hospitalar receptora',
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              palette: const [
                Colors.blue,
                Colors.orange,
                Colors.grey,
              ],
              series: <DoughnutSeries<_PieData, String>>[
                DoughnutSeries<_PieData, String>(
                    dataSource: _hospitalUnitGraph,
                    explodeIndex: 0,
                    xValueMapper: (_PieData data, _) => data.xData,
                    yValueMapper: (_PieData data, _) => data.yData,
                    dataLabelMapper: (_PieData data, _) =>
                        '${data.text}\n${data.yData}%',
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
              ],
              tooltipBehavior: TooltipBehavior(
                enable: true,
                format: 'point.x : point.y%',
              ),
            )
          ]),
        )),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 2.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Total',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                width: 1.0,
                height: 30.0,
                color: Colors.black,
              ),
              Expanded(
                child: Text(
                  '$_amountPP PPs',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);
  final String xData;
  final num yData;
  final String text;
}
