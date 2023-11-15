import 'package:flutter/material.dart';
import 'package:ppue/screens/Report/widgets/GraphEncRecep.widget.dart';
import 'package:ppue/screens/Report/widgets/GraphStatusClinica.widget.dart';
import 'package:ppue/screens/Report/widgets/GraphUMUH.widget.dart';

class ReportGraphs extends StatefulWidget {
  const ReportGraphs({Key? key}) : super(key: key);

  @override
  State<ReportGraphs> createState() => _ReportGraphsState();
}

class _ReportGraphsState extends State<ReportGraphs> {
  String selected = 'UM/UH';

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
                value: 'UM/UH',
                child: Text('Unidade Móvel / Unidade Hospitalar'),
              ),
              DropdownMenuItem(
                value: 'Enc/Recep',
                child: Text('PPs Enc./Recep.'),
              ),
              DropdownMenuItem(
                value: 'Status/Clinica',
                child: Text('Status / Cínica'),
              ),
            ],
          ),
        ),
        Expanded(
          child: selected == 'UM/UH'
              ? ReportGraphUMUH()
              : selected == 'Status/Clinica'
                  ? ReportGraphStatusClinica()
                  : selected == 'Enc/Recep'
                      ? ReportGraphEncRecep()
                      : Container(),
        )
      ],
    );
  }
}
