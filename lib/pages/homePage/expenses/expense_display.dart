import 'package:finance_app/classes/expense.dart';
import 'package:finance_app/shared/grey_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/db/database_service.dart';

class ExpenseDisplay extends StatefulWidget {
  final Expense expense;
  final void Function() reloadState;

  const ExpenseDisplay(
      {Key? key, required this.expense, required this.reloadState})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExpenseDisplayState();
}

class _ExpenseDisplayState extends State<ExpenseDisplay> {
  void showDeleteExpenseConfirm() {
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Yes",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      onPressed: () async {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deleting expense...')),
        );

        try {
          final db = DatabaseService();
          await db.openDb();
          await db.deleteExpense(widget.expense.id!).then((v) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Successfully deleted expense!')),
            );
          });
        } catch (ex) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to delete expense: ' + ex.toString())),
          );
        }

        widget.reloadState();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Delete Expense?"),
      content: const Text(
          "Are you sure you would like to permanently delete this expense?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: showDeleteExpenseConfirm,
        child: GreyBackground(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.expense.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
          height: 45,
        ));
  }
}
