import 'package:flutter/material.dart';

class TableNumeric extends StatelessWidget {
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
            child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text('Nome'),
            ),
            DataColumn(
              label: Text('Idade'),
            ),
            DataColumn(
              label: Text('Cidade'),
            ),
          ],
          rows: const <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('João')),
                DataCell(Text('25')),
                DataCell(Text('São Paulo')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Maria')),
                DataCell(Text('30')),
                DataCell(Text('Rio de Janeiro')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Pedro')),
                DataCell(Text('40')),
                DataCell(Text('Belo Horizonte')),
              ],
            ),
          ],
        ))
      ],
    );
  }
}
