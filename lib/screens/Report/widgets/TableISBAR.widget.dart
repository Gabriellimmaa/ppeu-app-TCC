import 'package:flutter/material.dart';
import 'package:ppue/core/notifier/database.notifier.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';

class TableISBAR extends StatefulWidget {
  const TableISBAR({
    Key? key,
  }) : super(key: key);

  @override
  TableISBARState createState() => TableISBARState();
}

class TableISBARState extends State<TableISBAR> {
  bool isLoading = true;
  List<DataRow> _data = [];
  final List<DataColumn> _column = [
    DataColumn(label: Text('Data PP')),
  ];

  Future<void> fetchMobileUnits(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    DatabaseNotifier databasePP =
        Provider.of<DatabaseNotifier>(context, listen: false);

    var responsePP = await databasePP.fetchStartDateEndDate(
      startDate: DateTime.now().subtract(Duration(days: 30)),
      endDate: DateTime.now().add(Duration(days: 1)),
    );

    Map<String, Map<String, int>> tempData = {};
    for (var element in responsePP) {
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
      _data = tempData
          .map((key, value) => MapEntry(
              key,
              DataRow(cells: [
                DataCell(Text(key)),
                ..._column.sublist(1).map((e) {
                  return DataCell(Text(
                      value[e.label.toString().toLowerCase()] != null
                          ? value[e.label.toString().toLowerCase()].toString()
                          : '0'));
                }).toList()
              ])))
          .values
          .toList();
      isLoading = false;
    });
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
    if (isLoading) return Center(child: CircularProgressIndicator());

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(columns: _column, rows: _data));
  }
}
