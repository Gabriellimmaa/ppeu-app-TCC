import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/models/PP/ResponsavelRecebimento.model.dart';
import 'package:ppue/utils/inputMask/cpf.mask.dart';
import 'package:ppue/utils/validation/FormValidators.validation.dart';

class ModalAddResponsavelRecebimento extends StatefulWidget {
  final Function(ResponsavelRecebimentoModel) onChanged;

  const ModalAddResponsavelRecebimento({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<ModalAddResponsavelRecebimento> createState() =>
      _ModalAddResponsavelRecebimentoState();
}

class _ModalAddResponsavelRecebimentoState
    extends State<ModalAddResponsavelRecebimento> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _cpfFocusNode = FocusNode();

  String? _selectedCargo;

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _cpfFocusNode.dispose();
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
                          'Adicionar Responsável Recebimento',
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
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => _cpfFocusNode.requestFocus(),
                      validator: FormValidators.required),
                  spacingRow,
                  TextFormField(
                      controller: _cpfController,
                      focusNode: _cpfFocusNode,
                      inputFormatters: [CPFMask.maskFormatter()],
                      decoration: InputDecoration(labelText: 'CPF'),
                      keyboardType: TextInputType.number,
                      validator: FormValidators.required),
                  spacingRow,
                  DropdownButtonFormField<String>(
                    value: _selectedCargo,
                    decoration: InputDecoration(labelText: 'Cargo'),
                    items: const [
                      DropdownMenuItem(
                        value: 'Enfermeiro(a)',
                        child: Text('Enfermeiro(a)'),
                      ),
                      DropdownMenuItem(
                        value: 'Médico(a)',
                        child: Text('Médico(a)'),
                      ),
                      DropdownMenuItem(
                        value: 'Outros',
                        child: Text('Outros'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedCargo = value;
                      });
                    },
                    validator: FormValidators.required,
                  ),
                  spacingRow,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        widget.onChanged(
                          ResponsavelRecebimentoModel(
                            nome: _nomeController.text,
                            cpf: _cpfController.text,
                            cargo: _selectedCargo!,
                          ),
                        );
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
