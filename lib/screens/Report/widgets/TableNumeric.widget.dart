import 'package:flutter/material.dart';
import 'package:ppue/screens/Report/widgets/TableISBAR.widget.dart';
import 'package:ppue/screens/Report/widgets/TableSTATUS.widget.dart';
import 'package:ppue/screens/Report/widgets/TableUH.widget.dart';
import 'package:ppue/screens/Report/widgets/TableUM.widget.dart';

class TableNumeric extends StatefulWidget {
  const TableNumeric({Key? key}) : super(key: key);

  @override
  TableNumericState createState() => TableNumericState();
}

class TableNumericState extends State<TableNumeric> {
  String selected = 'UM';

  @override
  void initState() {
    super.initState();
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
            value: selected,
            onChanged: (value) {
              setState(() {
                selected = value.toString();
              });
            },
            items: const [
              DropdownMenuItem(
                value: 'UM',
                child: Text('Unidade Móvel'),
              ),
              DropdownMenuItem(
                value: 'UH',
                child: Text('Unidade Hospitalar'),
              ),
              DropdownMenuItem(
                value: 'status',
                child: Text('Status'),
              ),
              DropdownMenuItem(
                value: 'ISBAR',
                child: Text('Clínica ISBAR'),
              ),
            ],
          ),
        ),
        Expanded(
          child: selected == 'UM'
              ? TableUM()
              : selected == 'UH'
                  ? TableUH()
                  : selected == 'status'
                      ? TableStatus()
                      : selected == 'ISBAR'
                          ? TableISBAR()
                          : Container(),
        )
      ],
    );
  }
}
