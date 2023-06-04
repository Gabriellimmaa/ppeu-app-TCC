import 'package:flutter/material.dart';

class NewPP_R extends StatefulWidget {
  const NewPP_R({Key? key}) : super(key: key);

  @override
  State<NewPP_R> createState() => _NewPP_RState();
}

class _NewPP_RState extends State<NewPP_R> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: const [
                  Text('Recomendações',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('Ações imediatas, tempo crítico ou não',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ],
              )),
        ],
      ),
    );
  }
}
