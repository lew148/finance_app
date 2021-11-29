import 'package:finance_app/db/database_service.dart';
import 'package:flutter/material.dart';

import 'budget_event_display.dart';

class Budgeting extends StatefulWidget {
  const Budgeting({Key? key}) : super(key: key);

  @override
  State<Budgeting> createState() => _BudgetingState();
}

class _BudgetingState extends State<Budgeting> {
  late Future<List<Widget>> _budgetEvents;

  Future<List<Widget>> getBudgetEventsWidget() async {
    List<Widget> budgetEvents = [];
    final db = DatabaseService();
    await db.openDb();

    for (var e in await db.getBudgetEvents()) {
      budgetEvents.add(BudgetEventDisplay(budgetEvent: e, reloadState: reloadState));
    }

    return budgetEvents;
  }

  @override
  void initState() {
    super.initState();
    _budgetEvents = getBudgetEventsWidget();
  }

  void reloadState() {
    setState(() {
      _budgetEvents = getBudgetEventsWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              'Your Bugdets',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            OutlinedButton(
                onPressed: () => {},
                child: const Icon(Icons.add, size: 26.0))
          ]),
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0)),
          FutureBuilder<List<Widget>>(
          future: _budgetEvents,
          builder:
              (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return Column(children: snapshot.data!);
              }
            }

            return Column(
              children: const [
                Text('No budget events here!'),
              ],
            );
          })
    ]);
  }
}
