import 'package:flutter/material.dart';
import 'package:ppeu/models/HospitalUnit.model.dart';
import 'package:ppeu/models/PP.model.dart';

class TableUH extends StatefulWidget {
  final List<PPModel> data;
  final List<HospitalUnitModel> hospitalData;
  const TableUH({Key? key, required this.data, required this.hospitalData})
      : super(key: key);

  @override
  TableUHState createState() => TableUHState();
}

class TableUHState extends State<TableUH> {
  bool isLoading = true;
  List<DataRow> _mobileUnitData = [];
  List<DataColumn> _mobileUnitColumn = [];

  Future<void> fetchMobileUnits(BuildContext context) async {
    List<DataColumn> temp = [DataColumn(label: Text('Data'))];
    temp.addAll(widget.hospitalData.map((element) {
      return DataColumn(label: Text(element.surname.toString()));
    }).toList());

    Map<String, Map<String, int>> somasPorDataEUnidade = {};
    for (var element in widget.data) {
      if (somasPorDataEUnidade[element.createdAt!] == null) {
        somasPorDataEUnidade[element.createdAt!] = {};
      }
      if (somasPorDataEUnidade[element.createdAt!]![
              element.recomendacoes.encaminhamento] ==
          null) {
        somasPorDataEUnidade[element.createdAt!]![
            element.recomendacoes.encaminhamento.name] = 0;
      }
      somasPorDataEUnidade[element.createdAt!]![
          element.recomendacoes.encaminhamento.name] = somasPorDataEUnidade[
              element.createdAt!]![element.recomendacoes.encaminhamento.name]! +
          1;
    }

    setState(() {
      _mobileUnitColumn = temp;
      _mobileUnitData = somasPorDataEUnidade
          .map((key, value) => MapEntry(
              key,
              DataRow(cells: [
                DataCell(Text(key)),
                ...widget.hospitalData.map((element) {
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
  void didUpdateWidget(TableUH oldWidget) {
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
