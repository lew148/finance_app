import 'package:flutter/material.dart';

class BudgetViewField extends StatefulWidget {
  final String title;
  final double? value;
  final Widget? widget;
  final MaterialColor? colourOfValue;
  final String? symbol;

  const BudgetViewField({
    Key? key,
    required this.title,
    @required this.value,
    @required this.widget,
    this.colourOfValue,
    this.symbol,
  }) : super(key: key);

  @override
  State<BudgetViewField> createState() => _BudgetViewFieldState();
}

class _BudgetViewFieldState extends State<BudgetViewField> {
  String getSymbol() {
    return widget.symbol != null ? widget.symbol! : "";
  }

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
                getSymbol() + ' £' + widget.value!.toStringAsFixed(2),
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
