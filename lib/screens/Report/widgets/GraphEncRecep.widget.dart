import 'package:flutter/material.dart';
import 'package:ppue/core/notifier/database.notifier.dart';
import 'package:ppue/core/notifier/hospitalUnit.notifier.dart';
import 'package:ppue/core/notifier/mobileUnit.notifier.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportGraphEncRecep extends StatefulWidget {
  const ReportGraphEncRecep({Key? key}) : super(key: key);

  @override
  State<ReportGraphEncRecep> createState() => _ReportGraphEncRecepState();
}

class _ReportGraphEncRecepState extends State<ReportGraphEncRecep> {
  bool isLoading = true;
  int _amountPP = 0;

  final List<StackedColumnSeries> _mobileUnitData = [];
  final List<StackedColumnSeries> _hospitalUnitData = [];

  Future<void> fetchMobileUnits(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    MobileUnitNotifier mobileUnitNotifier =
        Provider.of<MobileUnitNotifier>(context, listen: false);
    DatabaseNotifier databasePP =
        Provider.of<DatabaseNotifier>(context, listen: false);

    List<dynamic> data = await mobileUnitNotifier.fetchAll();

    var responsePP = await databasePP.fetchStartDateEndDate(
      startDate: DateTime.now().subtract(Duration(days: 30)),
      endDate: DateTime.now().add(Duration(days: 1)),
    );

    Map<String, Map<String, int>> sumData = {};
    for (var element in responsePP) {
      if (sumData[element.createdAt!] == null) {
        sumData[element.createdAt!] = {};
      }
      if (sumData[element.createdAt!]![
              element.identificacao.formaEncaminhamento] ==
          null) {
        sumData[element.createdAt!]![
            element.identificacao.formaEncaminhamento] = 0;
      }
      sumData[element.createdAt!]![element.identificacao.formaEncaminhamento] =
          sumData[element.createdAt!]![
                  element.identificacao.formaEncaminhamento]! +
              1;
    }

    setState(() {
      for (var element in data) {
        _mobileUnitData.add(
          StackedColumnSeries<_PieData, String>(
            dataSource: sumData
                .map((key, value) {
                  return MapEntry(
                      key,
                      _PieData(
                          key,
                          value[element.name] != null
                              ? value[element.name]!
                              : 0,
                          element.name));
                })
                .values
                .toList(),
            xValueMapper: (_PieData data, _) => data.xData,
            yValueMapper: (_PieData data, _) => data.yData,
            groupName: element.name,
            name: element.name,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            dataLabelMapper: (_PieData data, _) =>
                '${data.text}\n${data.yData}',
          ),
        );
      }
    });
  }

  Future<void> fetchHospitalUnits(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    HospitalUnitNotifier hospitalUnitNotifier =
        Provider.of<HospitalUnitNotifier>(context, listen: false);
    DatabaseNotifier databasePP =
        Provider.of<DatabaseNotifier>(context, listen: false);

    var data = await hospitalUnitNotifier.fetchAll();

    var responsePP = await databasePP.fetchStartDateEndDate(
      startDate: DateTime.now().subtract(Duration(days: 30)),
      endDate: DateTime.now().add(Duration(days: 1)),
    );

    Map<String, Map<String, int>> sumData = {};
    for (var element in responsePP) {
      if (sumData[element.createdAt!] == null) {
        sumData[element.createdAt!] = {};
      }
      if (sumData[element.createdAt!]![element.recomendacoes.encaminhamento] ==
          null) {
        sumData[element.createdAt!]![element.recomendacoes.encaminhamento] = 0;
      }
      sumData[element.createdAt!]![element.recomendacoes.encaminhamento] =
          sumData[element.createdAt!]![element.recomendacoes.encaminhamento]! +
              1;
    }

    setState(() {
      for (var element in data) {
        _hospitalUnitData.add(
          StackedColumnSeries<_PieData, String>(
            dataSource: sumData
                .map((key, value) {
                  return MapEntry(
                      key,
                      _PieData(
                          key,
                          value[element.name] != null
                              ? value[element.name]!
                              : 0,
                          element.name));
                })
                .values
                .toList(),
            xValueMapper: (_PieData data, _) => data.xData,
            yValueMapper: (_PieData data, _) => data.yData,
            groupName: element.surname,
            name: element.surname,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            dataLabelMapper: (_PieData data, _) =>
                '${data.text}\n${data.yData}',
          ),
        );
      }
    });
  }

  Future<void> fetchCountAllPP(BuildContext context) async {
    DatabaseNotifier database =
        Provider.of<DatabaseNotifier>(context, listen: false);
    int data = await database.fetchCountAll();
    _amountPP = data;
    setState(() {});
  }

  Future<void> fetchData(BuildContext context) async {
    await Future.wait([
      fetchMobileUnits(context),
      fetchHospitalUnits(context),
      fetchCountAllPP(context),
    ]);

    setState(() {
      isLoading = false;
    });
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
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            SfCartesianChart(
              title: ChartTitle(
                  text: 'PP Encaminhadas por Dia',
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
              primaryXAxis: CategoryAxis(),
              series: _mobileUnitData,
            ),
            SfCartesianChart(
              title: ChartTitle(
                  text: 'PP Recepcionados por Dia',
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
              primaryXAxis: CategoryAxis(),
              series: _hospitalUnitData,
            )
          ]),
        )),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 1.0,
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
                color: Colors.grey,
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
