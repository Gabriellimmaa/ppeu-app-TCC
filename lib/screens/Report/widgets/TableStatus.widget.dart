import 'package:flutter/material.dart';
import 'package:ppue/core/notifier/database.notifier.dart';
import 'package:ppue/models/PPStatus.model.dart';
import 'package:provider/provider.dart';

class TableStatus extends StatefulWidget {
  const TableStatus({
    Key? key,
  }) : super(key: key);

  @override
  TableStatusState createState() => TableStatusState();
}

class TableStatusState extends State<TableStatus> {
  bool isLoading = true;
  List<DataRow> _mobileUnitData = [];
  final List<DataColumn> _column = [
    DataColumn(label: Text('Data')),
    DataColumn(label: Text('Aguardando')),
    DataColumn(label: Text('Recepcionado')),
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
      isLoading = false;
    });
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
    if (isLoading) return Center(child: CircularProgressIndicator());

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(columns: _column, rows: _mobileUnitData));
  }
}
