import 'package:flutter/material.dart';

class BudgetViewField extends StatefulWidget {
  final String title;
  final double? value;
  final MaterialColor? colourOfValue;
  final Widget? widget;

  const BudgetViewField({
    Key? key,
    required this.title,
    @required this.value,
    @required this.widget,
    this.colourOfValue,
  }) : super(key: key);

  @override
  State<BudgetViewField> createState() => _BudgetViewFieldState();
}

class _BudgetViewFieldState extends State<BudgetViewField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        widget.value != null
            ? Text(
                '£' + widget.value!.toStringAsFixed(2),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: widget.colourOfValue,
                ),
              )
            : widget.widget!
      ],
    );
  }
}
