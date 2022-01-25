import 'package:finance_app/classes/expense.dart';
import 'package:finance_app/db/database_service.dart';
import 'package:finance_app/pages/homePage/expenses/expense_display.dart';
import 'package:flutter/material.dart';

import 'add_expense_form.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> _expenses = [];

  @override
  void initState() {
    super.initState();
    reloadState();
  }

  void reloadState() async {
    List<Expense> expenses = await getExpenses();

    setState(() {
      _expenses = expenses;
    });
  }

  Future<List<Expense>> getExpenses() async {
    final db = DatabaseService();
    await db.openDb();
    return await db.getExpenses();
  }

  List<Widget> getExpenseWidgets() {
    List<Widget> widgets = [];

    for (var e in _expenses) {
      widgets.add(ExpenseDisplay(expense: e, reloadState: reloadState));
    }

    return widgets;
  }

  double getExpensesTotal() {
    return _expenses.fold(0, (prev, e) => prev + e.cost);
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Expenses',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                _expenses.isEmpty
                ? const Text("")
                : Text(
                  "= £" + getExpensesTotal().toStringAsFixed(2),
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () => openAddExpenseForm(),
              child: const Icon(Icons.add, size: 26.0),
            ),
          ],
        ),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: _expenses.isEmpty
                ? const [Text("No expenses here! Create some :)")]
                : getExpenseWidgets(),
          ),
        ),
      ),
    ]);
  }
}
