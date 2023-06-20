import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportGraphPP extends StatefulWidget {
  const ReportGraphPP({Key? key}) : super(key: key);

  @override
  State<ReportGraphPP> createState() => _ReportGraphPPState();
}

class _ReportGraphPPState extends State<ReportGraphPP> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(DateTime(2023, 6, 1), 235, 240),
      ChartData(DateTime(2023, 6, 2), 242, 250),
      ChartData(DateTime(2023, 6, 3), 320, 280),
      ChartData(DateTime(2023, 6, 4), 360, 355),
      ChartData(DateTime(2023, 6, 5), 270, 245),
      ChartData(DateTime(2023, 6, 6), 270, 245),
      ChartData(DateTime(2023, 6, 7), 270, 245),
      ChartData(DateTime(2023, 6, 8), 270, 245),
      ChartData(DateTime(2023, 6, 9), 270, 245),
      ChartData(DateTime(2023, 6, 10), 270, 245),
      ChartData(DateTime(2023, 6, 11), 270, 245),
    ];

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat('dd/MM/yyyy'),
                    labelRotation: 45,
                  ),
                  primaryYAxis: NumericAxis(),
                  title: ChartTitle(
                    text: 'PP encaminhadas/dia',
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  series: <ChartSeries<ChartData, DateTime>>[
                    ColumnSeries<ChartData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                    ),
                    ColumnSeries<ChartData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y1,
                    ),
                  ],
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    header: '',
                    canShowMarker: true,
                    format: 'point.x : point.y',
                  ),
                ),
              ],
            ),
          ),
        ),
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
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final DateTime x;
  final double y;
  final double y1;
}
