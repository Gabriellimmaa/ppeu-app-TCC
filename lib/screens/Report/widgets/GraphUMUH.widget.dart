import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportGraphUMUH extends StatefulWidget {
  const ReportGraphUMUH({Key? key}) : super(key: key);

  @override
  State<ReportGraphUMUH> createState() => _ReportGraphUMUHState();
}

class _ReportGraphUMUHState extends State<ReportGraphUMUH> {
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
                    dataSource: <_PieData>[
                      _PieData('SIATE', 100, 'SIATE'),
                      _PieData('CONVÊNIOS', 75, 'CONVÊNIOS'),
                      _PieData('SAMU', 50, 'SAMU'),
                    ],
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
                    dataSource: <_PieData>[
                      _PieData('HU', 12, 'HU'),
                      _PieData('HZN', 14, 'HZN'),
                      _PieData('ISCAL', 74, 'ISCAL'),
                    ],
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
                  '231 PPs',
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
