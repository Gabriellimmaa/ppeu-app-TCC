import 'package:flutter/material.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:ppue/models/PPStatus.model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportGraphStatusClinica extends StatefulWidget {
  final List<PPModel> data;
  const ReportGraphStatusClinica({Key? key, required this.data})
      : super(key: key);

  @override
  State<ReportGraphStatusClinica> createState() =>
      _ReportGraphStatusClinicaState();
}

class _ReportGraphStatusClinicaState extends State<ReportGraphStatusClinica> {
  bool isLoading = true;
  List<_PieData> _dataISBAR = [];
  List<_PieData> _dataStatus = [];
  int _amountPP = 0;

  Future<void> fetchISBAR(BuildContext context) async {
    Map<String, int> tempData = {};
    for (var element in widget.data) {
      String value = element.situacao.clinica;
      if (tempData[value] == null) {
        tempData[value] = 0;
      }
      tempData[value] = tempData[value]! + 1;
    }

    _dataISBAR = tempData
        .map((key, value) {
          return MapEntry(key, _PieData(key, value, key));
        })
        .values
        .toList();
    setState(() {});
  }

  Future<void> fetchStatus(BuildContext context) async {
    Map<String, int> tempData = {};
    for (var element in widget.data) {
      String value = element.status!;
      if (tempData[value] == null) {
        tempData[value] = 0;
      }
      tempData[value] = tempData[value]! + 1;
    }

    _dataStatus = [
      _PieData('Aguardando', tempData[PPStatus.WAITING_CONFIRMATION] ?? 0,
          'Aguardando'),
      _PieData(
          'Recepcionado', tempData[PPStatus.CONFIRMED] ?? 0, 'Recepcionado'),
    ];

    setState(() {});
  }

  Future<void> fetchCountAllPP(BuildContext context) async {
    _amountPP = widget.data.length;
    setState(() {});
  }

  Future<void> fetchData(BuildContext context) async {
    await Future.wait([
      fetchStatus(context),
      fetchISBAR(context),
      fetchCountAllPP(context),
    ]);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void didUpdateWidget(ReportGraphStatusClinica oldWidget) {
    if (widget.data != oldWidget.data) {
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
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            SfCartesianChart(
              title: ChartTitle(
                  text: 'Unidade Móvel / Unidade Hospitalar',
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries<_PieData, String>>[
                ColumnSeries<_PieData, String>(
                    dataSource: _dataStatus,
                    xValueMapper: (_PieData data, _) => data.xData,
                    yValueMapper: (_PieData data, _) => data.yData,
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
              ],
              tooltipBehavior: TooltipBehavior(
                enable: true,
                format: 'point.x : point.y',
              ),
            ),
            SfCircularChart(
              title: ChartTitle(
                  text: 'Situação Clínica ISBAR',
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
                    dataSource: _dataISBAR,
                    explodeIndex: 0,
                    xValueMapper: (_PieData data, _) => data.xData,
                    yValueMapper: (_PieData data, _) => data.yData,
                    dataLabelMapper: (_PieData data, _) =>
                        '${data.text}\n${(data.yData / _amountPP * 100).toStringAsFixed(2)}%',
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
              ],
              tooltipBehavior: TooltipBehavior(
                enable: true,
                format: 'point.x : point.y',
              ),
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
