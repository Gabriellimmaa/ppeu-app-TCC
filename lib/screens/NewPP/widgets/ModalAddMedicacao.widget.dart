import 'package:flutter/material.dart';
import 'package:ppeu/constants/constants.dart';
import 'package:ppeu/models/PP/PCR.model.dart';
import 'package:ppeu/utils/validation/FormValidators.validation.dart';
import 'package:ppeu/widgets/GradientButton.widget.dart';
import 'package:ppeu/widgets/inputs/TimePickerTextField.widget.dart';

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
                            splashRadius: 20,
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
                        child: GradientButton(
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
