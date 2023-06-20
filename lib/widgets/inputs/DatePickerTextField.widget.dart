import 'package:flutter/material.dart';

class DatePickerTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final InputDecoration? decoration;

  const DatePickerTextField({
    Key? key,
    required this.controller,
    this.validator,
    this.labelText,
    this.decoration,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      String formattedDate = '${picked.day}/${picked.month}/${picked.year}';
      controller.text = formattedDate;
      if (validator != null) {
        String? validationMessage = validator!(formattedDate);
        if (validationMessage != null) {
          // Faça algo com a mensagem de validação, se necessário
          print(validationMessage);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () {
        _selectDate(context);
      },
      decoration: decoration ??
          InputDecoration(
            labelText: labelText ?? 'Selecione uma data',
            suffixIcon: Icon(Icons.calendar_today),
          ),
    );
  }
}
