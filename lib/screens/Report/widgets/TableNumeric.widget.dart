import 'package:flutter/material.dart';
import 'package:ppue/core/notifier/database.notifier.dart';
import 'package:ppue/core/notifier/mobileUnit.notifier.dart';
import 'package:provider/provider.dart';

class TableNumeric extends StatefulWidget {
  const TableNumeric({Key? key}) : super(key: key);

  @override
  TableNumericState createState() => TableNumericState();
}

class TableNumericState extends State<TableNumeric> {
  List<DataRow> _mobileUnitData = [];
  List<DataColumn> _mobileUnitColumn = [];

  Future<void> fetchMobileUnits(BuildContext context) async {
    MobileUnitNotifier mobileUnitNotifier =
        Provider.of<MobileUnitNotifier>(context, listen: false);
    DatabaseNotifier databasePP =
        Provider.of<DatabaseNotifier>(context, listen: false);

    List<dynamic> data = await mobileUnitNotifier.fetchAll();

    List<DataColumn> temp = [DataColumn(label: Text('Por UM enc.'))];
    temp.addAll(data.map((element) {
      return DataColumn(label: Text(element.name.toString()));
    }).toList());

    var responsePP = await databasePP.fetchStartDateEndDate(
      startDate: DateTime.now().subtract(Duration(days: 30)),
      endDate: DateTime.now().add(Duration(days: 1)),
    );

    Map<String, Map<String, int>> somasPorDataEUnidade = {};
    responsePP.forEach((element) {
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
    });

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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: DropdownButton(
            isExpanded: true,
            value: 'Por UM enc.',
            onChanged: (value) {},
            items: const [
              DropdownMenuItem(
                value: 'Por UM enc.',
                child: Text('Por UM enc.'),
              ),
              DropdownMenuItem(
                value: 'Selecione2',
                child: Text('Selecione2'),
              ),
              DropdownMenuItem(
                value: 'Selecione3',
                child: Text('Selecione3'),
              ),
            ],
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    columns: _mobileUnitColumn, rows: _mobileUnitData)))
      ],
    );
  }
}
