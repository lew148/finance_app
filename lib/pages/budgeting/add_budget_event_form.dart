import 'package:finance_app/classes/budget_event.dart';
import 'package:finance_app/classes/expense.dart';
import 'package:finance_app/db/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddBudgetEventForm extends StatefulWidget {
  final void Function() reloadState;

  const AddBudgetEventForm({Key? key, required this.reloadState})
      : super(key: key);

  @override
  State<AddBudgetEventForm> createState() => _AddBudgetEventFormState();
}

class _AddBudgetEventFormState extends State<AddBudgetEventForm> {
  final _formKey = GlobalKey<FormState>();
  final incomeController = TextEditingController();

  @override
  void dispose() {
    incomeController.dispose();
    super.dispose();
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
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: incomeController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        try {
                          final moneyRegex =
                              RegExp(r'^[^0][0-9]*(.[1-9]{0,2}$)*$');
                          final newText = newValue.text;
                          if (newText.isEmpty || moneyRegex.hasMatch(newText)) {
                            return newValue;
                          }
                          // ignore: empty_catches
                        } catch (e) {}
                        return oldValue;
                      }),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Income',
                      isDense: true,
                      prefixIcon: Text('£'),
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 20, minHeight: 0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Adding budget event to db...')),
                              );

                              try {
                                final db = DatabaseService();
                                await db.openDb();
                                await db.insertBudgetEvent(BudgetEvent(
                                  id: null,
                                  income: double.parse(incomeController.text),
                                  date: DateTime.now(),
                                )).then((v) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Successfully added Budget Event!')),
                                  );
                                });
                              } catch (ex) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Failed to add expense: ' + ex.toString())),
                                );
                              }

                              widget.reloadState();
                            }
                          },
                          child: const Text('Add'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
