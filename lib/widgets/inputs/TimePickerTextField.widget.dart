import 'package:flutter/material.dart';

class TimePickerTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final Function(TimeOfDay)? onChanged;
  final bool? readOnly;
  final FocusNode? focusNode;

  const TimePickerTextField({
    Key? key,
    required this.controller,
    this.readOnly = true,
    this.focusNode,
    this.validator,
    this.labelText,
    this.onChanged,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      controller.text = '${picked.hour}:${picked.minute}';
      onChanged?.call(picked);
      if (validator != null) {
        String? validationMessage = validator!(picked.toString());
        if (validationMessage != null) {
          // Faça algo com a mensagem de validação, se necessário
          print(validationMessage);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? true,
      onTap: () {
        _selectDate(context);
      },
      decoration: InputDecoration(
        labelText: labelText ?? 'Selecione uma horário',
        suffixIcon: Icon(Icons.timer),
      ),
      validator: validator,
      focusNode: focusNode,
    );
  }
}
