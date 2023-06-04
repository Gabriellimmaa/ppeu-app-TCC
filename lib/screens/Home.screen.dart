import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppue/screens/NewPPScreen.screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE d MMMM yyyy', 'pt_BR').format(now);
    String formattedTime = DateFormat('HH:mm').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text('PPEU'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    '$formattedTime $formattedDate',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text(
                    'Bem Vindo(a) Gabriel!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  'UM - SAMU Londrina',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(
                height: 10,
                thickness: 2,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewPPScreen()));
                      },
                      child: Stack(
                        children: const [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.add),
                          ),
                          Align(
                              alignment: Alignment.center,
                              heightFactor: 1.5,
                              child: Text(
                                'Cadastrar nova PP',
                              )),
                        ],
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Stack(
                        children: const [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.search),
                          ),
                          Align(
                              alignment: Alignment.center,
                              heightFactor: 1.5,
                              child: Text(
                                'Consultar PP',
                              )),
                        ],
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Stack(
                        children: const [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.message),
                          ),
                          Align(
                              alignment: Alignment.center,
                              heightFactor: 1.5,
                              child: Text(
                                'Mensageiro PPEU',
                              )),
                        ],
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Stack(
                        children: const [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.list),
                          ),
                          Align(
                              alignment: Alignment.center,
                              heightFactor: 1.5,
                              child: Text(
                                'Relatórios',
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(
                height: 10,
                thickness: 2,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Resumo de PPs realizadas hoje:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  child: ListView(
                    shrinkWrap: true,
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
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
