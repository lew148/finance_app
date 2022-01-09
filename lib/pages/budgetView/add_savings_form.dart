import 'package:finance_app/db/database_service.dart';
import 'package:finance_app/shared/forms/single_monetary_input_form.dart';
import 'package:flutter/material.dart';

class AddSavingsForm extends StatefulWidget {
  final int budgetEventId;
  final void Function() reloadState;

  const AddSavingsForm({
    Key? key,
    required this.budgetEventId,
    required this.reloadState,
  }) : super(key: key);

  @override
  State<AddSavingsForm> createState() => _AddSavingsFormState();
}

class _AddSavingsFormState extends State<AddSavingsForm> {
  void onSubmit(GlobalKey<FormState> formKey,
      TextEditingController valueController) async {
    if (formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adding Savings to Budget Event...')),
      );

      try {
        final db = DatabaseService();
        await db.openDb();
        await db.addSavingsToBudgetEvent(
            widget.budgetEventId, double.parse(valueController.text));
      } catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add savings: ' + ex.toString())),
        );
      }

      widget.reloadState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleMonetaryInputForm(
      title: 'Add Savings',
      fieldLabel: 'Savings',
      submitText: 'Save',
      onSubmit: onSubmit,
    );
  }
}
