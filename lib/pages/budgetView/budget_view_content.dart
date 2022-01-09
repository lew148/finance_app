import 'package:finance_app/classes/budget_event.dart';
import 'package:finance_app/db/database_service.dart';
import 'package:finance_app/pages/budgetView/add_savings_form.dart';
import 'package:finance_app/pages/budgetView/budget_view_field.dart';
import 'package:finance_app/shared/grey_background.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dotted_line/dotted_line.dart';

class BudgetViewContent extends StatefulWidget {
  final BudgetEvent budgetEvent;

  const BudgetViewContent({Key? key, required this.budgetEvent})
      : super(key: key);

  @override
  State<BudgetViewContent> createState() => _BudgetViewContentState();
}

class _BudgetViewContentState extends State<BudgetViewContent> {
  late BudgetEvent _budgetEvent;
  late Future<List<Widget>> _budgetedExpenses;

  @override
  void initState() {
    super.initState();
    _budgetEvent = widget.budgetEvent;
    _budgetedExpenses = getBudgetedExpenseWidgets();
  }

  void reloadState() async {
    final db = DatabaseService();
    await db.openDb();
    BudgetEvent budgetEvent = await db.getBudgetEvent(_budgetEvent.id);

    setState(() {
      _budgetEvent = budgetEvent;
      _budgetedExpenses = getBudgetedExpenseWidgets();
    });
  }

  Future<List<Widget>> getBudgetedExpenseWidgets() async {
    List<Widget> budgetedExpenses = [];
    final db = DatabaseService();
    await db.openDb();

    for (var be in await db.getBudgetedExpenses(_budgetEvent.id!)) {
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

  void openAddSavingsForm() => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddSavingsForm(
                  budgetEventId: _budgetEvent.id!,
                  reloadState: reloadState,
                ))
          ],
          mainAxisSize: MainAxisSize.min,
        ),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
            DateFormat('dd-MM-yyyy').format(_budgetEvent.date),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          padding: const EdgeInsets.only(bottom: 45),
        ),
        BudgetViewField(
          title: 'Income',
          value: _budgetEvent.income,
          colourOfValue: Colors.green,
        ),
        const SizedBox(height: 10),
        BudgetViewField(
          title: 'Savings',
          value: _budgetEvent.savings,
          widget: _budgetEvent.savings == null
              ? OutlinedButton(
                  onPressed: () => openAddSavingsForm(),
                  child: const Icon(Icons.add, size: 26.0),
                )
              : null,
          colourOfValue: Colors.orange,
        ),
        const SizedBox(height: 10),
        GreyBackground(
          child: Column(children: [
            BudgetViewField(
              title: 'Expenses Total',
              value: _budgetEvent.expensesTotal,
              colourOfValue: Colors.red,
            ),
            Container(
              child: const DottedLine(),
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 10),
            ),
            FutureBuilder<List<Widget>>(
                future: _budgetedExpenses,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Widget>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return SingleChildScrollView(
                        child: Column(children: snapshot.data!),
                      );
                    }
                  }

                  return Column(
                    children: const [
                      Text('No budgeted expenses for this event!'),
                    ],
                  );
                }),
          ]),
        )
      ],
    );
  }
}
