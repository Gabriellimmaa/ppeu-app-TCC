import 'package:flutter/material.dart';
import 'package:ppeu/constants/constants.dart';
import 'package:ppeu/utils/validation/FormValidators.validation.dart';
import 'package:ppeu/widgets/GradientButton.widget.dart';

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            splashRadius: 20,
                          )
                        ],
                      ),
                      spacingRow,
                      TextFormField(
                          controller: _nomeController,
                          decoration:
                              InputDecoration(labelText: 'Nome completo'),
                          validator: FormValidators.required),
                      spacingRow,
                      SizedBox(
                        width: double.infinity,
                        child: GradientButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;

                            widget.onChanged(_nomeController.text);
                            Navigator.pop(context);
                          },
                          height: 40,
                          child: Text('Adicionar',
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ]),
              )),
        ));
  }
}
