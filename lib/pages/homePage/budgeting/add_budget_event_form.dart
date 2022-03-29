import 'package:finance_app/classes/budget_event.dart';
import 'package:finance_app/db/database_service.dart';
import 'package:finance_app/pages/budgetView/budget_view.dart';
import 'package:finance_app/shared/forms/money_input_field.dart';
import 'package:flutter/material.dart';

class AddBudgetEventForm extends StatefulWidget {
  final void Function() reloadState;

  const AddBudgetEventForm({Key? key, required this.reloadState})
      : super(key: key);

  @override
  State<AddBudgetEventForm> createState() => _AddBudgetEventFormState();
}

class _AddBudgetEventFormState extends State<AddBudgetEventForm> {
  final formKey = GlobalKey<FormState>();
  final valueController = TextEditingController();

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      Navigator.pop(context);

      try {
        final db = DatabaseService();
        await db.openDb();
        await db
            .insertBudgetEvent(BudgetEvent(
          id: null,
          income: double.parse(valueController.text),
          date: DateTime.now(),
        ))
            .then((v) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BudgetView(budgetEventId: v)),
          );
        });
      } catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add expense: ' + ex.toString())),
        );
      }

      widget.reloadState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'New Budget',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                MoneyInputField(label: 'Income', controller: valueController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ElevatedButton(
                        onPressed: onSubmit,
                        child: const Text('Add'),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
