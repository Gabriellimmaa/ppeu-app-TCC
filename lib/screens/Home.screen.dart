import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppue/core/notifier/user.notifier.dart';
import 'package:ppue/screens/ManagePP/ManagePP.screen.dart';
import 'package:ppue/screens/NewPP/NewPP.screen.dart';
import 'package:ppue/screens/Report/Report.screen.dart';
import 'package:ppue/screens/SearchPP/SearchPP.screen.dart';
import 'package:ppue/widgets/CustomScaffold.widget.dart';
import 'package:ppue/widgets/GradientButton.widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE d MMMM yyyy', 'pt_BR').format(now);
    String formattedTime = DateFormat('HH:mm').format(now);

    UserNotifier userNotifier = Provider.of<UserNotifier>(
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
              // Ação de logout
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
                children: const [
                  Text(
                    'Bem Vindo(a) Gabriel!',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    'UM - SAMU Londrina',
                    style: TextStyle(fontSize: 24, color: Colors.white),
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
                        child: SingleChildScrollView(
                          child: ListView(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              ListTile(
                                title: Text('HU - Londrina'),
                                leading: Icon(Icons.person),
                                onTap: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('2 pacientes'),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Text('HZN'),
                                leading: Icon(Icons.person),
                                onTap: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('2 pacientes'),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Text('ISCAL - Santa Casa de Londrina'),
                                leading: Icon(Icons.person),
                                onTap: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('2 pacientes'),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Text('SAMU - Londrina'),
                                leading: Icon(Icons.person),
                                onTap: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('2 pacientes'),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Text('SAMU - Londrina'),
                                leading: Icon(Icons.person),
                                onTap: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('2 pacientes'),
                                  ],
                                ),
                              ),
                            ],
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
                          onPressed: () {
                            userNotifier.isMovel
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewPPScreen()))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ManagePPScreen()));
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
                                    userNotifier.isMovel
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
                                    builder: (context) => SearchPPScreen()));
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
