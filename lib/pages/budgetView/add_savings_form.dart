import 'package:finance_app/db/database_service.dart';
import 'package:finance_app/shared/forms/money_input_field.dart';
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
  final formKey = GlobalKey<FormState>();
  final valueController = TextEditingController();

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      Navigator.pop(context);

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
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Add Savings',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                MoneyInputField(label: 'Savings', controller: valueController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ElevatedButton(
                        onPressed: onSubmit,
                        child: const Text('Save'),
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
