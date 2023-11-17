import 'package:flutter/material.dart';
import 'package:ppeu/constants/constants.dart';
import 'package:ppeu/models/PP.model.dart';

class TableISBAR extends StatefulWidget {
  final List<PPModel> data;
  const TableISBAR({Key? key, required this.data}) : super(key: key);

  @override
  TableISBARState createState() => TableISBARState();
}

class TableISBARState extends State<TableISBAR> {
  final List<DataRow> _data = [];
  final List<DataColumn> _column = [
    DataColumn(label: Text('Data PP')),
  ];

  Future<void> fetchMobileUnits(BuildContext context) async {
    Map<String, Map<String, int>> tempData = {};
    for (var element in widget.data) {
      String createdAt = element.createdAt!;
      String value = element.situacao.clinica;
      if (tempData[createdAt] == null) {
        tempData[createdAt] = {};
      }
      if (tempData[createdAt]![value] == null) {
        tempData[createdAt]![value] = 0;
      }
      tempData[createdAt]![value] = tempData[createdAt]![value]! + 1;
    }

    setState(() {
      _data.addAll(
        tempData.keys.map((element) {
          List<DataCell> temp = [DataCell(Text(element))];
          temp.addAll(
            optionsClinica.map((option) {
              return DataCell(
                Text(
                  tempData[element]![option] != null
                      ? tempData[element]![option].toString()
                      : '0',
                ),
              );
            }).toList(),
          );
          return DataRow(cells: temp);
        }).toList(),
      );
    });
  }

  @override
  void didUpdateWidget(TableISBAR oldWidget) {
    if (widget.data != oldWidget.data) {
      fetchMobileUnits(context);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    for (var element in optionsClinica) {
      _column.add(DataColumn(label: Text(element)));
    }
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
        child: DataTable(columns: _column, rows: _data));
  }
}
