import 'package:finance_app/classes/budget_event.dart';
import 'package:finance_app/db/database_service.dart';
import 'package:finance_app/pages/budgetView/budget_view.dart';
import 'package:finance_app/shared/forms/single_monetary_input_form.dart';
import 'package:flutter/material.dart';

class AddBudgetEventForm extends StatefulWidget {
  final void Function() reloadState;

  const AddBudgetEventForm({Key? key, required this.reloadState})
      : super(key: key);

  @override
  State<AddBudgetEventForm> createState() => _AddBudgetEventFormState();
}

class _AddBudgetEventFormState extends State<AddBudgetEventForm> {
  void onSubmit(GlobalKey<FormState> formKey,
      TextEditingController valueController) async {
    if (formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adding budget event to db...')),
      );

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
                  builder: (context) => BudgetView(budgetEventId: v)));
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
    return SingleMonetaryInputForm(
      title: 'New Budget',
      fieldLabel: 'Income',
      submitText: 'Add',
      onSubmit: onSubmit,
    );
  }
}
