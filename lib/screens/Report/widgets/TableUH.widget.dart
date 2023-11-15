import 'package:flutter/material.dart';
import 'package:ppue/core/notifier/database.notifier.dart';
import 'package:ppue/core/notifier/hospitalUnit.notifier.dart';
import 'package:provider/provider.dart';

class TableUH extends StatefulWidget {
  const TableUH({
    Key? key,
  }) : super(key: key);

  @override
  TableUHState createState() => TableUHState();
}

class TableUHState extends State<TableUH> {
  bool isLoading = true;
  List<DataRow> _mobileUnitData = [];
  List<DataColumn> _mobileUnitColumn = [];

  Future<void> fetchMobileUnits(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    HospitalUnitNotifier databaseHospital =
        Provider.of<HospitalUnitNotifier>(context, listen: false);
    DatabaseNotifier databasePP =
        Provider.of<DatabaseNotifier>(context, listen: false);

    var data = await databaseHospital.fetchAll();

    List<DataColumn> temp = [DataColumn(label: Text('Data'))];
    temp.addAll(data.map((element) {
      return DataColumn(label: Text(element.surname.toString()));
    }).toList());

    var responsePP = await databasePP.fetchStartDateEndDate(
      startDate: DateTime.now().subtract(Duration(days: 30)),
      endDate: DateTime.now().add(Duration(days: 1)),
    );

    Map<String, Map<String, int>> somasPorDataEUnidade = {};
    for (var element in responsePP) {
      if (somasPorDataEUnidade[element.createdAt!] == null) {
        somasPorDataEUnidade[element.createdAt!] = {};
      }
      if (somasPorDataEUnidade[element.createdAt!]![
              element.recomendacoes.encaminhamento] ==
          null) {
        somasPorDataEUnidade[element.createdAt!]![
            element.recomendacoes.encaminhamento] = 0;
      }
      somasPorDataEUnidade[element.createdAt!]![
          element.recomendacoes.encaminhamento] = somasPorDataEUnidade[
              element.createdAt!]![element.recomendacoes.encaminhamento]! +
          1;
    }

    setState(() {
      _mobileUnitColumn = temp;
      _mobileUnitData = somasPorDataEUnidade
          .map((key, value) => MapEntry(
              key,
              DataRow(cells: [
                DataCell(Text(key)),
                ...data.map((element) {
                  return DataCell(Text(value[element.name] != null
                      ? value[element.name].toString()
                      : "0"));
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
        child: DataTable(columns: _mobileUnitColumn, rows: _mobileUnitData));
  }
}
