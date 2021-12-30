import 'package:finance_app/classes/budgeted_expense.dart';
import 'package:flutter/material.dart';

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
  late Future<List<BudgetedExpense>> expenses;

  @override
  Widget build(BuildContext context) {
    return Text('lol');
  }
}
