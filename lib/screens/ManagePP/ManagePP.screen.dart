import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:ppue/screens/SearchPP/SearchPP_List.screen.dart';
import 'package:ppue/utils/formater/DateFormatter.util.dart';
import 'package:ppue/widgets/GradientContainer.widget.dart';
import 'package:ppue/widgets/inputs/DatePickerTextField.widget.dart';
import 'package:ppue/widgets/inputs/DropdownTextField.widget.dart';

class ManagePPScreen extends StatefulWidget {
  const ManagePPScreen({Key? key}) : super(key: key);

  @override
  State<ManagePPScreen> createState() => _ManagePPScreenState();
}

class _ManagePPScreenState extends State<ManagePPScreen> {
  DateTime selectedDate = DateTime.now();
  String? _selectedItem;
  String buttonText = 'Selecione';
  final TextEditingController _dateController = TextEditingController();
  int _selectedButtonIndex = 0;
  final List<PPModel> items = [
    examplePP,
    examplePP,
    examplePP,
    examplePP,
    examplePP,
    examplePP,
    examplePP
  ];

  int _currentSegment = 0;

  final List<bool> _selectedFruits = <bool>[true, false, false];

  bool vertical = false;
  List<Widget> fruits = <Widget>[Text('Apple'), Text('Banana'), Text('Orange')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GERENCIAR PPs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: gradientContainer(
          child: Column(
            children: [
              SizedBox(height: 70),
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 16,
                ),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                        hintText: 'Pesquisar',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.white.withOpacity(0.5),
                      size: 34,
                    ),
                  )
                ]),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedButtonIndex = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedButtonIndex == 0
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 10.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Todos',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedButtonIndex = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedButtonIndex == 1
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 10.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Recepcionados',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedButtonIndex = 2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedButtonIndex == 2
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 10.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Aguardando',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1),
              Expanded(
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      PPModel item = items[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ViewPPScreen(data: item),
                          //   ),
                          // );
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 16),
                                // leading: Image.network(
                                //   item.imageUrl,
                                //   width: 50,
                                //   height: 50,
                                //   fit: BoxFit.cover,
                                // ),
                                trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.list_alt),
                                      // Icon(Icons.check_box,
                                      //     color: Colors.green),
                                      Icon(
                                        Icons.access_time_filled,
                                        color: Colors.yellow.shade900,
                                      )
                                    ]),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.identificacao.nome,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      formatDate(
                                        DateTime.parse(
                                            item.identificacao.dataNascimento),
                                        format: FormatDate.diaMesNomeAno,
                                      ),
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                subtitle: Column(children: [
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                          'DN: ${item.identificacao.dataNascimento}'),
                                      Text(
                                          '- Unidade/hospital: ${item.identificacao.formaEncaminhamento}'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Reponsável pelo encaminhamento: ${item.situacao.enfermeiroResponsavelTransferencia}',
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
