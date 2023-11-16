import 'package:flutter/material.dart';

class DatePickerTextField extends StatefulWidget {
  final DateTime? value;
  final ValueChanged<DateTime?>? onChanged;
  final String? Function(String?)? validator;
  final String? labelText;
  final InputDecoration? decoration;

  const DatePickerTextField({
    Key? key,
    required this.value,
    this.onChanged,
    this.validator,
    this.labelText,
    this.decoration,
  }) : super(key: key);

  @override
  DatePickerTextFieldState createState() => DatePickerTextFieldState();
}

class DatePickerTextFieldState extends State<DatePickerTextField> {
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(
      text: widget.value != null
          ? '${widget.value?.day}/${widget.value?.month}/${widget.value?.year}'
          : '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _dateController,
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
          visible: _dateController.text.isNotEmpty,
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
                _dateController.text = '';
                widget.onChanged?.call(null);
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
      initialDate: widget.value ?? DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        widget.onChanged?.call(picked);
        _dateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
      if (widget.validator != null) {
        String? validationMessage =
            widget.validator!(picked.toString().substring(0, 10));
        if (validationMessage != null) {
          // Faça algo com a mensagem de validação, se necessário
          print(validationMessage);
        }
      }
    }
  }
}
