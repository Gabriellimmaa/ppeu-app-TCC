import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppeu/core/notifier/authentication.notifier.dart';
import 'package:ppeu/core/notifier/database.notifier.dart';
import 'package:ppeu/models/PP.model.dart';
import 'package:ppeu/models/PPStatus.model.dart';
import 'package:ppeu/screens/ViewPP.screen.dart';
import 'package:ppeu/widgets/GradientContainer.widget.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class ManagePPScreen extends StatefulWidget {
  const ManagePPScreen({Key? key}) : super(key: key);

  @override
  State<ManagePPScreen> createState() => _ManagePPScreenState();
}

class _ManagePPScreenState extends State<ManagePPScreen> {
  bool isLoading = true;
  DateTime selectedDate = DateTime.now();
  String buttonText = 'Selecione';
  String _selectedButtonIndex = 'all';
  List<dynamic> data = [];
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  Timer? _debounce;

  bool vertical = false;
  List<Widget> fruits = <Widget>[Text('Apple'), Text('Banana'), Text('Orange')];

  Future<void> fetchAllPP(BuildContext context) async {
    DatabaseNotifier databaseNotifier =
        Provider.of<DatabaseNotifier>(context, listen: false);
    AuthenticationNotifier userNotifier = Provider.of<AuthenticationNotifier>(
      context,
      listen: false,
    );
    var response = await databaseNotifier.filterByStatus(
      status: 'all',
      name: '',
      date: '',
      hospitalUnit: userNotifier.hospitalUnit,
    );
    data = response;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _nameController.dispose();
    _debounce?.cancel();
    super.dispose();
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
    AuthenticationNotifier userNotifier = Provider.of<AuthenticationNotifier>(
      context,
      listen: false,
    );

    _onSearchChanged() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      isLoading = true;
      _debounce = Timer(const Duration(milliseconds: 500), () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          barrierDismissible: false,
        );
        isLoading = false;
        try {
          var response = await databaseNotifier.filterByStatus(
              status: _selectedButtonIndex,
              name: _nameController.text,
              date: _dateController.text,
              hospitalUnit: userNotifier.hospitalUnit);

          if (response.isEmpty) {
            // ignore: use_build_context_synchronously
            Navigator.pop(context); // Fecha o diálogo de loading
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Nenhuma PP encontrada'),
                  content: Text(
                      'Não foi encontrado nenhuma passagem de plantão com os dados informados.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            setState(() {
              data = response;
            });
          }
        } catch (e) {
          Navigator.pop(context); // Fecha o diálogo de loading em caso de erro
        }
      });
    }

    Future<void> fetchFilterByStatus(String status) async {
      isLoading = true;
      var response = await databaseNotifier.filterByStatus(
          status: status,
          name: _nameController.text,
          date: _dateController.text,
          hospitalUnit: userNotifier.hospitalUnit);
      setState(() {
        isLoading = false;
        data = response;
      });
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
              SizedBox(height: 75),
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        onChanged: (data) => _onSearchChanged(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          hintText: 'Nome do paciente',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2018),
                          lastDate: DateTime(2030),
                        );

                        if (date != null) {
                          _dateController.text =
                              DateFormat('yyyy-MM-dd').format(date);
                          _onSearchChanged();
                        }
                      },
                      icon: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white.withOpacity(0.5),
                            size: 34,
                          ),
                          if (_dateController.text.isNotEmpty)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: GestureDetector(
                                onTap: () {
                                  _dateController.text = "";
                                  _onSearchChanged();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors
                                        .red, // Pode ser uma cor que chame atenção
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
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
              isLoading
                  ? Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : data.isEmpty
                      ? Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Nenhuma PP encontrada',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Expanded(
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
                                          canEditStatus:
                                              item.status == PPStatus.CONFIRMED
                                                  ? false
                                                  : true,
                                        ),
                                      ),
                                    ).then((value) => fetchFilterByStatus(
                                        _selectedButtonIndex));
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
                                              if (item.status ==
                                                  PPStatus.CONFIRMED)
                                                Icon(Icons.check_box,
                                                    color: Colors.green),
                                              if (item.status ==
                                                  PPStatus.WAITING_CONFIRMATION)
                                                Icon(Icons.access_time_filled,
                                                    color:
                                                        Colors.yellow.shade900),
                                            ],
                                          ),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                item.identificacao.nome,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                item.createdAt.toString(),
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
                                                    ' - UM: ${item.identificacao.formaEncaminhamento}'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Resp. Enc.: ${item.situacao.enfermeiroResponsavelTransferencia}',
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
