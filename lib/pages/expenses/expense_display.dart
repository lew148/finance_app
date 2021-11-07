import 'package:finance_app/classes/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseDisplay extends StatefulWidget {
  final Expense expense;

  const ExpenseDisplay({Key? key, required this.expense}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExpenseDisplayState();
}

class _ExpenseDisplayState extends State<ExpenseDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.expense.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Row(
            children: [
              Text(
                '£' + widget.expense.cost.toStringAsFixed(2),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ],
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
      height: 45,
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
    );
  }
}
