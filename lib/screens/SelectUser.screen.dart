import 'package:flutter/material.dart';
import 'package:ppue/screens/Home.screen.dart';

class SelectUserScreen extends StatefulWidget {
  const SelectUserScreen({Key? key}) : super(key: key);

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PPEU'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('IMAGEM'),
            Column(
              children: [
                Text('Estabelecimento de saúde'),
                DropdownButton(
                    value: 'mobileHu',
                    items: const [
                      DropdownMenuItem(
                        value: 'mobileHu',
                        child: Text('Hospitalar - HU Londrina'),
                      ),
                      DropdownMenuItem(
                        value: 'hospitalHzn',
                        child: Text('Hospitalar - HZN'),
                      ),
                      DropdownMenuItem(
                        value: 'hospitalIscal',
                        child: Text('Hospitalar - ISCAL'),
                      ),
                      DropdownMenuItem(
                        value: 'samuLondrina',
                        child: Text('Móvel - SAMU/Londrina'),
                      )
                    ],
                    onChanged: (value) {}),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child: Text('Logar como unidade móvel'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('Logar como unidade hospitalar'),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
