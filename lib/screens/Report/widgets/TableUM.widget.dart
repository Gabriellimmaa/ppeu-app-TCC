import 'package:flutter/material.dart';
import 'package:ppue/models/MobileUnit.model.dart';
import 'package:ppue/models/PP.model.dart';

class TableUM extends StatefulWidget {
  final List<PPModel> data;
  final List<MobileUnitModel> mobileData;
  const TableUM({Key? key, required this.data, required this.mobileData})
      : super(key: key);

  @override
  TableUMState createState() => TableUMState();
}

class TableUMState extends State<TableUM> {
  List<DataRow> _mobileUnitData = [];
  List<DataColumn> _mobileUnitColumn = [];

  Future<void> fetchMobileUnits(BuildContext context) async {
    List<DataColumn> temp = [DataColumn(label: Text('Data'))];
    temp.addAll(widget.mobileData.map((element) {
      return DataColumn(label: Text(element.name.toString()));
    }).toList());

    Map<String, Map<String, int>> somasPorDataEUnidade = {};
    for (var element in widget.data) {
      if (somasPorDataEUnidade[element.createdAt!] == null) {
        somasPorDataEUnidade[element.createdAt!] = {};
      }
      if (somasPorDataEUnidade[element.createdAt!]![
              element.identificacao.formaEncaminhamento] ==
          null) {
        somasPorDataEUnidade[element.createdAt!]![
            element.identificacao.formaEncaminhamento] = 0;
      }
      somasPorDataEUnidade[element.createdAt!]![
          element.identificacao.formaEncaminhamento] = somasPorDataEUnidade[
              element.createdAt!]![element.identificacao.formaEncaminhamento]! +
          1;
    }

    setState(() {
      _mobileUnitColumn = temp;
      _mobileUnitData = somasPorDataEUnidade
          .map((key, value) => MapEntry(
              key,
              DataRow(cells: [
                DataCell(Text(key)),
                ...widget.mobileData.map((element) {
                  return DataCell(Text(value[element.name] != null
                      ? value[element.name].toString()
                      : "0"));
                }).toList()
              ])))
          .values
          .toList();
    });
  }

  @override
  void didUpdateWidget(TableUM oldWidget) {
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
        child: DataTable(columns: _mobileUnitColumn, rows: _mobileUnitData));
  }
}
