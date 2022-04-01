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
  late Future<List<Widget>> _budgetedExpenseWidgets;

  @override
  void initState() {
    super.initState();
    _budgetEvent = widget.budgetEvent;
    _budgetedExpenseWidgets = getBudgetedExpenseWidgets();
  }

  void reloadState() async {
    final db = DatabaseService();
    await db.openDb();
    BudgetEvent budgetEvent = await db.getBudgetEvent(_budgetEvent.id);

    setState(() {
      _budgetEvent = budgetEvent;
      _budgetedExpenseWidgets = getBudgetedExpenseWidgets();
    });
  }

  void onDeleteBudgetedExpenseButton(int id) async {
    
  }

  Future<List<Widget>> getBudgetedExpenseWidgets() async {
    List<Widget> budgetedExpenses = [];
    final db = DatabaseService();
    await db.openDb();

    for (var be in await db.getBudgetedExpenses(_budgetEvent.id!)) {
      budgetedExpenses.add(
        Container(
          margin: const EdgeInsets.only(bottom: 5.0),
          child: Row(
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
              SizedBox(
                height: 22,
                width: 50,
                child: OutlinedButton(
                  onPressed: () => onDeleteBudgetedExpenseButton(be.id!),
                  child:
                      const Icon(Icons.remove, size: 11.0, color: Colors.red),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                ),
              )
            ],
          ),
        ),
      );
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

  double getLeftOver() {
    double leftOver = _budgetEvent.income -
        (_budgetEvent.expensesTotal == null ? 0 : _budgetEvent.expensesTotal!);
    double? savings = _budgetEvent.savings;

    if (savings != null) {
      leftOver = leftOver - savings;
    }

    return leftOver;
  }

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
        ),
        const SizedBox(height: 10),
        BudgetViewField(
          title: 'Savings',
          value: _budgetEvent.savings,
          colourOfValue: Colors.orange,
          symbol: "-",
          widget: _budgetEvent.savings == null
              ? OutlinedButton(
                  onPressed: () => openAddSavingsForm(),
                  child: const Icon(Icons.add, size: 26.0),
                )
              : null,
        ),
        const SizedBox(height: 10),
        GreyBackground(
          child: Column(children: [
            BudgetViewField(
              title: 'Expenses Total',
              value: _budgetEvent.expensesTotal,
              colourOfValue: Colors.red,
              symbol: "-",
              widget: _budgetEvent.expensesTotal == null
                  ? OutlinedButton(
                      onPressed: () => openAddSavingsForm(),
                      child: const Icon(Icons.add, size: 26.0),
                    )
                  : null,
            ),
            Container(
              child: const DottedLine(),
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 10),
            ),
            FutureBuilder<List<Widget>>(
                future: _budgetedExpenseWidgets,
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
        ),
        const SizedBox(height: 10),
        BudgetViewField(
          title: 'Left Over',
          value: getLeftOver(),
          colourOfValue: Colors.green,
          symbol: "=",
        ),
      ],
    );
  }
}
