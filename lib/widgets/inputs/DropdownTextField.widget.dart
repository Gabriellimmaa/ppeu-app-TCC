import 'package:flutter/material.dart';

class DropdownOption<T> {
  final String displayText;
  final T value;

  DropdownOption({required this.displayText, required this.value});
}

class DropdownTextField<T> extends StatefulWidget {
  final String labelText;
  final List<DropdownOption<T>> options;
  final T? defaultValue;
  final ValueChanged<T?> onChanged;

  const DropdownTextField({
    Key? key,
    required this.labelText,
    required this.options,
    this.defaultValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DropdownTextFieldState<T> createState() => _DropdownTextFieldState<T>();
}

class _DropdownTextFieldState<T> extends State<DropdownTextField<T>> {
  T? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: _selectedOption,
      decoration: InputDecoration(
        labelText: widget.labelText,
      ),
      items: widget.options.map((DropdownOption<T> option) {
        return DropdownMenuItem<T>(
          value: option.value,
          child: Text(option.displayText),
        );
      }).toList(),
      onChanged: (T? newValue) {
        setState(() {
          _selectedOption = newValue;
        });
        widget.onChanged(newValue);
      },
    );
  }
}
