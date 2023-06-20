import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';

class ModalReportFilters extends StatefulWidget {
  final Function(String) onChanged;

  const ModalReportFilters({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<ModalReportFilters> createState() => _ModalReportFiltersState();
}

class _ModalReportFiltersState extends State<ModalReportFilters> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Filtrar Relatórios',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                        ),
                      )
                    ],
                  ),
                  spacingRow,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.car_crash),
                          SizedBox(width: 8),
                          Text('UM'),
                          SizedBox(width: 16),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: DropdownButton(
                          isExpanded: true,
                          value: 'Selecione',
                          onChanged: (value) {},
                          items: const [
                            DropdownMenuItem(
                              value: 'Selecione',
                              child: Text('Selecione'),
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.remove_red_eye),
                          SizedBox(width: 8),
                          Text('St. Recep.'),
                          SizedBox(width: 16),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: DropdownButton(
                          isExpanded: true,
                          value: 'Selecione',
                          onChanged: (value) {},
                          items: const [
                            DropdownMenuItem(
                              value: 'Selecione',
                              child: Text('Selecione'),
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.local_hospital),
                          SizedBox(width: 8),
                          Text('UM'),
                          SizedBox(width: 16),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: DropdownButton(
                          isExpanded: true,
                          value: 'Selecione',
                          onChanged: (value) {},
                          items: const [
                            DropdownMenuItem(
                              value: 'Selecione',
                              child: Text('Selecione'),
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
                    ],
                  ),
                  spacingRow,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onChanged(_nomeController.text);
                        Navigator.pop(context);
                      },
                      child: Text('Filtrar'),
                    ),
                  )
                ]),
          )),
    ));
  }
}
