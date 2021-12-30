import 'package:finance_app/classes/budget_event.dart';
import 'package:finance_app/db/database_service.dart';
import 'package:finance_app/pages/budgetView/budget_view_content.dart';
import 'package:flutter/material.dart';

class BudgetView extends StatefulWidget {
  final int budgetEventId;

  const BudgetView({Key? key, required this.budgetEventId}) : super(key: key);

  @override
  State<BudgetView> createState() => _BudgetViewState();
}

class _BudgetViewState extends State<BudgetView> {
  late Future<BudgetEvent> _budgetEvent;

  @override
  void initState() {
    super.initState();
    _budgetEvent = getBudgetEvent();
  }

  Future<BudgetEvent> getBudgetEvent() async {
    final db = DatabaseService();
    await db.openDb();
    return db.getBudgetEvent(widget.budgetEventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Finance App',
          style: TextStyle(fontSize: 25.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: FutureBuilder<BudgetEvent>(
          future: _budgetEvent,
          builder: (BuildContext context, AsyncSnapshot<BudgetEvent> snapshot) {
            if (snapshot.hasData) {

              return BudgetViewContent(
                budgetEventId: widget.budgetEventId,
                income: ,
              );
            }

            return Column(
              children: const [
                Text('Could not find Budget Event :('),
              ],
            );
          },
        ),
      ),
    );
  }
}
