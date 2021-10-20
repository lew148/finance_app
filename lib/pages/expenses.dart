import 'package:finance_app/classes/expense.dart';
import 'package:finance_app/pages/expense_display.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Widget> getExpensesWidget() {
    List<Widget> expenses = [];

    for (var e in ExpenseHelper.getTestExpenses()) {
      expenses.add(ExpenseDisplay(expense: e));
    }

    return expenses;
  }

  double getExpensesTotal() => ExpenseHelper.getTestExpenses()
      .fold(0, (sum, expense) => sum + expense.cost);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              'Expenses',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              textAlign: TextAlign.left,
            ),
            Column(children: [
              const Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                child: Text(
                  '£' + getExpensesTotal().toStringAsFixed(2),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.green),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                padding: const EdgeInsets.all(2.5),
              ),
            ]),
          ]),
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        ),
        Column(children: getExpensesWidget())
      ],
    );
  }
}
