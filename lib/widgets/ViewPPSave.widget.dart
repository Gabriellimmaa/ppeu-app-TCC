import 'package:flutter/material.dart';
import 'package:ppeu/models/PP.model.dart';

class ViewPPSave extends StatefulWidget {
  final PPModel data;

  const ViewPPSave({Key? key, required this.data}) : super(key: key);

  @override
  _ViewPPSaveState createState() => _ViewPPSaveState();
}

class _ViewPPSaveState extends State<ViewPPSave> {
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();

    controllers = {};
    for (var attribute in widget.data.toJson().keys) {
      // Cria um TextEditingController para cada atributo
      controllers[attribute] =
          TextEditingController(text: widget.data.toJson()[attribute]);
    }
  }

  @override
  void dispose() {
    // Descarta todos os controllers ao sair da tela
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Tela'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var attribute in widget.data.toJson().keys)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  TextField(
                    controller: controllers[attribute],
                    decoration: InputDecoration(
                      labelText: attribute,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
