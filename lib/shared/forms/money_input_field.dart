import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoneyInputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const MoneyInputField({
    Key? key,
    required this.label,
    required this.controller
  }) : super(key: key);

  @override
  State<MoneyInputField> createState() => _MoneyInputFieldState();
}

class _MoneyInputFieldState extends State<MoneyInputField> {
  static const String moneyRegex = r'^[^0][0-9]*(.[0-9]{0,2}$)*$';

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType:
          const TextInputType.numberWithOptions(decimal: true, signed: false),
      inputFormatters: [
        TextInputFormatter.withFunction((oldValue, newValue) {
          try {
            final regEx = RegExp(moneyRegex);
            final newText = newValue.text;
            if (newText.isEmpty || regEx.hasMatch(newText)) {
              return newValue;
            }
            // ignore: empty_catches
          } catch (e) {}
          return oldValue;
        }),
      ],
      decoration: InputDecoration(
        labelText: widget.label,
        isDense: true,
        prefixIcon: const Text('£'),
        prefixIconConstraints: const BoxConstraints(minWidth: 20, minHeight: 0),
      ),
    );
  }
}
