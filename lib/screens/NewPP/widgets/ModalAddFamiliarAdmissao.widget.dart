import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';

class ModalAddFamiliarAdmissao extends StatefulWidget {
  final Function(String) onChanged;
  const ModalAddFamiliarAdmissao({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<ModalAddFamiliarAdmissao> createState() =>
      _ModalAddFamiliarAdmissaoState();
}

class _ModalAddFamiliarAdmissaoState extends State<ModalAddFamiliarAdmissao> {
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
                          'Adicionar Familiar',
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
                  TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(labelText: 'Nome completo'),
                  ),
                  spacingRow,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onChanged(_nomeController.text);
                        Navigator.pop(context);
                      },
                      child: Text('Adicionar'),
                    ),
                  )
                ]),
          )),
    ));
  }
}
