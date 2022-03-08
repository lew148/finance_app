import 'package:finance_app/classes/budget_event.dart';
import 'package:finance_app/db/database_service.dart';
import 'package:finance_app/pages/budgetView/budget_view.dart';
import 'package:finance_app/shared/grey_background.dart';
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
        builder: (context) => BudgetView(budgetEventId: widget.budgetEvent.id!),
      ),
    ).then((value) => widget.reloadState());
  }

  void showDeleteBudgetEventConfirm() {
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

        try {
          final db = DatabaseService();
          await db.openDb();
          await db.deleteBudgetEvent(widget.budgetEvent.id!);
        } catch (ex) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to delete Budget Event: ' + ex.toString())),
          );
        }

        widget.reloadState();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Delete Budget Event?"),
      content: const Text(
          "Are you sure you would like to permanently delete this Budget Event?"),
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
      onTap: onTap,
      onLongPress: showDeleteBudgetEventConfirm,
      child: GreyBackground(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('dd-MM-yyyy').format(widget.budgetEvent.date),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(
              '£' + widget.budgetEvent.income.toStringAsFixed(2),
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
        height: 45,
      ),
    );
  }
}
