import 'package:finance_app/db/database_service.dart';
import 'package:finance_app/pages/expenses/expense_display.dart';
import 'package:flutter/material.dart';

import 'add_expense_form.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  late Future<List<Widget>> _expenses;

  Future<List<Widget>> getExpensesWidget() async {
    List<Widget> expenses = [];
    final db = DatabaseService();
    await db.openDb();

    for (var e in await db.getExpenses()) {
      expenses.add(ExpenseDisplay(expense: e, reloadState: reloadState));
    }

    return expenses;
  }

  @override
  void initState() {
    super.initState();
    _expenses = getExpensesWidget();
  }

  void reloadState() {
    setState(() {
      _expenses = getExpensesWidget();
    });
  }

  void openAddExpenseForm() => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddExpenseForm(reloadState: reloadState))
          ],
          mainAxisSize: MainAxisSize.min,
        ),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      );

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              'Your Expenses',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            OutlinedButton(
                onPressed: () => openAddExpenseForm(),
                child: const Icon(Icons.add, size: 26.0))
          ]),
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0)),
      FutureBuilder<List<Widget>>(
          future: _expenses,
          builder:
              (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return Column(children: snapshot.data!);
              }
            }

            return Column(
              children: const [
                Text('No expenses here! Create some :)'),
              ],
            );
          })
    ]);
  }
}
