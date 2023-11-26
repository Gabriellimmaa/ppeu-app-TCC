import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppeu/core/notifier/authentication.notifier.dart';
import 'package:ppeu/core/notifier/database.notifier.dart';
import 'package:ppeu/core/notifier/hospitalUnit.notifier.dart';
import 'package:ppeu/models/PP.model.dart';
import 'package:ppeu/models/PPStatus.model.dart';
import 'package:ppeu/screens/ManagePP/ManagePP.screen.dart';
import 'package:ppeu/screens/NewPP/NewPP.screen.dart';
import 'package:ppeu/screens/Report/Report.screen.dart';
import 'package:ppeu/screens/SearchPP/SearchPP.screen.dart';
import 'package:ppeu/widgets/CustomScaffold.widget.dart';
import 'package:ppeu/widgets/GradientButton.widget.dart';
import 'package:provider/provider.dart' as provider;
import 'package:supabase/supabase.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<ListTile> data = [];
  RealtimeSubscription? subscription;
  int notificationCount = 0;

  Future fetchNotification(
      {required AuthenticationNotifier authenticationNotifier,
      required DatabaseNotifier databaseNotifier}) async {
    var responsePPWainting = await databaseNotifier.filterPP(
      nome: null,
      responsavelRecebimentoCpf: null,
      hospitalUnit: authenticationNotifier.hospitalUnit?.id,
      startDate: null,
      endDate: null,
      status: PPStatus.WAITING_CONFIRMATION,
    );

    setState(() {
      notificationCount = responsePPWainting.length;
    });
  }

  Future fetchData({required DatabaseNotifier databaseNotifier}) async {
    HospitalUnitNotifier hospitalUnitNotifier =
        provider.Provider.of<HospitalUnitNotifier>(
      context,
      listen: false,
    );

    var responseHospitalUnit = await hospitalUnitNotifier.fetchAll();

    for (var element in responseHospitalUnit) {
      var response = await databaseNotifier.filterPP(
        nome: null,
        responsavelRecebimentoCpf: null,
        hospitalUnit: element.id,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 1)),
      );

      data.add(
        ListTile(
          title: Text(element.name),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${response.length} pacientes'),
            ],
          ),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    AuthenticationNotifier authenticationNotifier =
        provider.Provider.of<AuthenticationNotifier>(
      context,
      listen: false,
    );
    DatabaseNotifier databaseNotifier = provider.Provider.of<DatabaseNotifier>(
      context,
      listen: false,
    );

    if (authenticationNotifier.type == UserType.HOSPITAL_UNIT) {
      fetchNotification(
          authenticationNotifier: authenticationNotifier,
          databaseNotifier: databaseNotifier);

      subscription = databaseNotifier.openRealtimeInsert(
        onNotificationReceived: (PPModel? pp) {
          setState(() {
            if (pp != null) {
              if (pp.recomendacoes.encaminhamento ==
                  authenticationNotifier.hospitalUnit!.name) {
                notificationCount++;
              }
            }
          });
        },
      );
    }

    fetchData(
      databaseNotifier: databaseNotifier,
    );
  }

  @override
  void dispose() {
    subscription?.unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE d MMMM yyyy', 'pt_BR').format(now);
    String formattedTime = DateFormat('HH:mm').format(now);

    AuthenticationNotifier authenticationNotifier =
        provider.Provider.of<AuthenticationNotifier>(
      context,
      listen: false,
    );

    DatabaseNotifier databaseNotifier = provider.Provider.of<DatabaseNotifier>(
      context,
      listen: false,
    );

    return CustomScaffold(
      appBar: AppBar(
        title: Text('PPEU'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authenticationNotifier.logout(context: context);
            },
          ),
        ],
      ),
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Text(
                '$formattedTime $formattedDate',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 120, top: 16),
              child: Column(
                children: [
                  Text(
                    'Bem Vindo(a) ${authenticationNotifier.firstName}!',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    authenticationNotifier.hospitalUnit?.name ??
                        authenticationNotifier.mobileUnit!.name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 16, top: 50),
                        child: Text(
                          'Resumo de PPs realizadas hoje:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : SingleChildScrollView(
                                child: ListView(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(0),
                                  physics: NeverScrollableScrollPhysics(),
                                  children: data,
                                ),
                              ),
                      )
                    ],
                  )),
            )
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: double.infinity,
                  // color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        GradientButton(
                          notificationCount: authenticationNotifier.isMovel
                              ? 0
                              : notificationCount,
                          onPressed: () {
                            authenticationNotifier.isMovel
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewPPScreen()))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ManagePPScreen(
                                              onClose: (p0) => {
                                                fetchNotification(
                                                    authenticationNotifier:
                                                        authenticationNotifier,
                                                    databaseNotifier:
                                                        databaseNotifier)
                                              },
                                            )));
                          },
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  heightFactor: 3,
                                  child: Text(
                                    authenticationNotifier.isMovel
                                        ? 'Cadastrar nova PP '
                                        : 'Gerenciamento de PP',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        GradientButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPPScreen(
                                          hospitalUnit: authenticationNotifier
                                              .hospitalUnit,
                                          mobileUnit:
                                              authenticationNotifier.mobileUnit,
                                        )));
                          },
                          child: Stack(
                            children: const [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                heightFactor: 3,
                                child: Text('Consultar PP',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        GradientButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportScreen()));
                          },
                          child: Stack(
                            children: const [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.list,
                                  color: Colors.white,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                heightFactor: 3,
                                child: Text('Relatórios',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}
