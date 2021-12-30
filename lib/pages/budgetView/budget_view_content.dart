import 'package:finance_app/db/database_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetViewContent extends StatefulWidget {
  final int budgetEventId;
  final double income;
  final DateTime date;
  final double expensesTotal;

  const BudgetViewContent({
    Key? key,
    required this.budgetEventId,
    required this.income,
    required this.date,
    required this.expensesTotal,
  }) : super(key: key);

  @override
  State<BudgetViewContent> createState() => _BudgetViewContentState();
}

class _BudgetViewContentState extends State<BudgetViewContent> {
  late Future<List<Widget>> _budgetedExpenses;

  @override
  void initState() {
    super.initState();
    _budgetedExpenses = getBudgetedExpenseWidgets();
  }

  void reloadState() {
    setState(() {
      _budgetedExpenses = getBudgetedExpenseWidgets();
    });
  }

  Future<List<Widget>> getBudgetedExpenseWidgets() async {
    List<Widget> budgetedExpenses = [];
    final db = DatabaseService();
    await db.openDb();

    for (var be in await db.getBudgetedExpenses(widget.budgetEventId)) {
      budgetedExpenses.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            be.name,
            style: const TextStyle(fontSize: 17),
          ),
          Text(
            '- £' + be.cost.toStringAsFixed(2),
            style: const TextStyle(color: Colors.red, fontSize: 17),
          ),
        ],
      ));
    }

    return budgetedExpenses;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
            DateFormat('dd-MM-yyyy').format(widget.date),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          padding: const EdgeInsets.only(bottom: 45),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Income',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '£' + widget.income.toStringAsFixed(2),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Expenses Total',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '£' + widget.expensesTotal.toStringAsFixed(2),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
            ),
          ],
        ),
        FutureBuilder<List<Widget>>(
            future: _budgetedExpenses,
            builder:
                (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return Container(
                    child: SingleChildScrollView(
                      child: Column(children: snapshot.data!),
                    ),
                    decoration: const BoxDecoration(
                        border: Border(top: BorderSide(width: 1.0))),
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  );
                }
              }

              return Column(
                children: const [
                  Text('No budgeted expenses for this event!'),
                ],
              );
            }),
      ],
    );
  }
}
