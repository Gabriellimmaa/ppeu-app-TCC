import 'package:flutter/material.dart';
import 'package:ppeu/models/HospitalUnit.model.dart';
import 'package:ppeu/models/MobileUnit.model.dart';
import 'package:ppeu/models/PP.model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportGraphUMUH extends StatefulWidget {
  final List<PPModel> data;
  final List<HospitalUnitModel> hospitalData;
  final List<MobileUnitModel> mobileData;

  const ReportGraphUMUH(
      {Key? key,
      required this.data,
      required this.hospitalData,
      required this.mobileData})
      : super(key: key);

  @override
  State<ReportGraphUMUH> createState() => _ReportGraphUMUHState();
}

class _ReportGraphUMUHState extends State<ReportGraphUMUH> {
  List<_PieData> _hospitalUnitGraph = [];
  List<_PieData> _mobileUnitGraph = [];
  int _amountPP = 0;

  Future<void> fetchHospitalUnits(BuildContext context) async {
    _hospitalUnitGraph = widget.hospitalData.map((element) {
      return _PieData(
          element.surname, element.amount, element.surname.toString());
    }).toList();
    setState(() {});
  }

  Future<void> fetchMobileUnits(BuildContext context) async {
    _mobileUnitGraph = widget.mobileData.map((element) {
      return _PieData(element.name, element.amount, element.name.toString());
    }).toList();
    setState(() {});
  }

  Future<void> fetchCountAllPP(BuildContext context) async {
    _amountPP = widget.data.length;
    setState(() {});
  }

  @override
  void didUpdateWidget(ReportGraphUMUH oldWidget) {
    if (widget.mobileData != oldWidget.mobileData) {
      fetchMobileUnits(context);
    }

    if (widget.hospitalData != oldWidget.hospitalData) {
      fetchHospitalUnits(context);
    }

    if (widget.data != oldWidget.data) {
      fetchCountAllPP(context);
    }

    super.didUpdateWidget(oldWidget);
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
                  text: 'Unidade Móvel Encaminhadora',
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
                        '${data.text}\n${(data.yData / _amountPP * 100).toStringAsFixed(2)}%',
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
              ],
              tooltipBehavior: TooltipBehavior(
                enable: true,
                format: 'point.x : point.y',
              ),
            ),
            SfCircularChart(
              title: ChartTitle(
                  text: 'Unidade Hospitalar Receptora',
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
