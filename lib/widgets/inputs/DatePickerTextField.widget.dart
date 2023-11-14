import 'package:flutter/material.dart';

class DatePickerTextField extends StatefulWidget {
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

  @override
  _DatePickerTextFieldState createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            readOnly: true,
            onTap: () {
              _selectDate(context);
            },
            decoration: widget.decoration ??
                InputDecoration(
                  labelText: widget.labelText ?? 'Selecione uma data',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
          ),
        ),
        Visibility(
          visible: widget.controller.text.isNotEmpty,
          child: IconButton(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.close,
                size: 14,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              setState(() {
                widget.controller.text = '';
              });
            },
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      String formattedDate = '${picked.day}/${picked.month}/${picked.year}';
      setState(() {
        widget.controller.text = formattedDate;
      });
      if (widget.validator != null) {
        String? validationMessage = widget.validator!(formattedDate);
        if (validationMessage != null) {
          // Faça algo com a mensagem de validação, se necessário
          print(validationMessage);
        }
      }
    }
  }
}
