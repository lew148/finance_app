import 'package:finance_app/classes/budget_event.dart';
import 'package:finance_app/pages/budgetView/budget_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetEventDisplay extends StatefulWidget {
  final BudgetEvent budgetEvent;
  final void Function() reloadState;

  const BudgetEventDisplay(
      {Key? key, required this.budgetEvent, required this.reloadState})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BudgetEventDisplayState();
}

class _BudgetEventDisplayState extends State<BudgetEventDisplay> {
  void onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
          BudgetView(budgetEventId: widget.budgetEvent.id!)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('dd-MM-yyyy').format(widget.budgetEvent.date),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(
              '£' + widget.budgetEvent.income.toStringAsFixed(2),
              style: const TextStyle(fontSize: 15, color: Colors.green),
            ),
            Text(
              '£' + widget.budgetEvent.expensesTotal!.toStringAsFixed(2),
              style: const TextStyle(fontSize: 15, color: Colors.red),
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
      ),
    );
  }
}