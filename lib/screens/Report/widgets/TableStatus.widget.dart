import 'package:flutter/material.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:ppue/models/PPStatus.model.dart';

class TableStatus extends StatefulWidget {
  final List<PPModel> data;
  const TableStatus({Key? key, required this.data}) : super(key: key);

  @override
  TableStatusState createState() => TableStatusState();
}

class TableStatusState extends State<TableStatus> {
  List<DataRow> _mobileUnitData = [];
  final List<DataColumn> _column = [
    DataColumn(label: Text('Data')),
    DataColumn(label: Text('Aguardando')),
    DataColumn(label: Text('Recepcionado')),
  ];

  Future<void> fetchMobileUnits(BuildContext context) async {
    Map<String, Map<String, int>> tempData = {};
    for (var element in widget.data) {
      String createdAt = element.createdAt!;
      String value = element.status!;
      if (tempData[createdAt] == null) {
        tempData[createdAt] = {};
      }
      if (tempData[createdAt]![value] == null) {
        tempData[createdAt]![value] = 0;
      }
      tempData[createdAt]![value] = tempData[createdAt]![value]! + 1;
    }

    setState(() {
      _mobileUnitData = tempData
          .map((key, value) => MapEntry(
              key,
              DataRow(cells: [
                DataCell(Text(key)),
                DataCell(Text(value[PPStatus.WAITING_CONFIRMATION] != null
                    ? value[PPStatus.WAITING_CONFIRMATION].toString()
                    : '0')),
                DataCell(Text(value[PPStatus.CONFIRMED] != null
                    ? value[PPStatus.CONFIRMED].toString()
                    : '0')),
              ])))
          .values
          .toList();
    });
  }

  @override
  void didUpdateWidget(TableStatus oldWidget) {
    if (widget.data != oldWidget.data) {
      fetchMobileUnits(context);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    fetchMobileUnits(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(columns: _column, rows: _mobileUnitData));
  }
}
