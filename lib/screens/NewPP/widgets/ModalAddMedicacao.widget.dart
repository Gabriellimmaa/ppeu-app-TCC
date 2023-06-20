import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/models/PP/PCR.model.dart';
import 'package:ppue/utils/validation/FormValidators.validation.dart';
import 'package:ppue/widgets/inputs/TimePickerTextField.widget.dart';

class ModalAddMedicacao extends StatefulWidget {
  final Function(PCRMedicacao) onChanged;

  const ModalAddMedicacao({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<ModalAddMedicacao> createState() => _ModalAddMedicacaoState();
}

class _ModalAddMedicacaoState extends State<ModalAddMedicacao> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _doseController = TextEditingController();
  final _horarioController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _doseController.dispose();
    _horarioController.dispose();
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
            autovalidateMode: AutovalidateMode.always,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Adicionar Medicação',
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
                      decoration: InputDecoration(labelText: 'Nome'),
                      textInputAction: TextInputAction.next,
                      validator: FormValidators.required),
                  spacingRow,
                  TextFormField(
                      controller: _doseController,
                      decoration: InputDecoration(labelText: 'Dose'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.go,
                      validator: FormValidators.required),
                  spacingRow,
                  TimePickerTextField(
                      controller: _horarioController,
                      labelText: 'Horário',
                      validator: FormValidators.required),
                  spacingRow,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        widget.onChanged(PCRMedicacao(
                          nome: _nomeController.text,
                          dose: _doseController.text,
                          horario: _horarioController.text,
                        ));
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
