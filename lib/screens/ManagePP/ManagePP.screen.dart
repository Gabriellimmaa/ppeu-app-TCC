import 'package:flutter/material.dart';
import 'package:ppue/core/notifier/database.notifier.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:ppue/models/PPStatus.model.dart';
import 'package:ppue/screens/ViewPP.screen.dart';
import 'package:ppue/widgets/GradientContainer.widget.dart';
import 'package:provider/provider.dart';

class ManagePPScreen extends StatefulWidget {
  const ManagePPScreen({Key? key}) : super(key: key);

  @override
  State<ManagePPScreen> createState() => _ManagePPScreenState();
}

class _ManagePPScreenState extends State<ManagePPScreen> {
  DateTime selectedDate = DateTime.now();
  String buttonText = 'Selecione';
  String _selectedButtonIndex = 'all';
  List<dynamic> data = [];

  bool vertical = false;
  List<Widget> fruits = <Widget>[Text('Apple'), Text('Banana'), Text('Orange')];

  Future<void> fetchAllPP(BuildContext context) async {
    DatabaseNotifier databaseNotifier =
        Provider.of<DatabaseNotifier>(context, listen: false);
    var response = await databaseNotifier.fetchAll();
    data = response;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchAllPP(context);
  }

  @override
  Widget build(BuildContext context) {
    DatabaseNotifier databaseNotifier =
        Provider.of<DatabaseNotifier>(context, listen: false);

    Future<void> fetchFilterByStatus(String status) async {
      if (status == 'all') {
        var response = await databaseNotifier.fetchAll();
        setState(() {
          data = response;
        });
      } else {
        var response = await databaseNotifier.filterByStatus(status: status);
        setState(() {
          data = response;
        });
      }
    }

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
                          _selectedButtonIndex = 'all';
                          fetchFilterByStatus('all');
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedButtonIndex == 'all'
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
                          _selectedButtonIndex = PPStatus.CONFIRMED;
                          fetchFilterByStatus(PPStatus.CONFIRMED);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedButtonIndex == 'CONFIRMED'
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
                          _selectedButtonIndex = PPStatus.WAITING_CONFIRMATION;
                          fetchFilterByStatus(PPStatus.WAITING_CONFIRMATION);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color:
                                  _selectedButtonIndex == 'WAITING_CONFIRMATION'
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
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      PPModel item = data[index];
                      return GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewPPScreen(
                                data: item,
                                canEditStatus: item.status == PPStatus.CONFIRMED
                                    ? false
                                    : true,
                              ),
                            ),
                          ).then((value) =>
                              fetchFilterByStatus(_selectedButtonIndex));
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
                                    if (item.status == PPStatus.CONFIRMED)
                                      Icon(Icons.check_box,
                                          color: Colors.green),
                                    if (item.status ==
                                        PPStatus.WAITING_CONFIRMATION)
                                      Icon(Icons.access_time_filled,
                                          color: Colors.yellow.shade900),
                                  ],
                                ),
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
                                      item.identificacao.dataNascimento,
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
