import 'package:finance_app/classes/expense.dart';
import 'package:finance_app/db/database_service.dart';
import 'package:finance_app/shared/forms/money_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpenseForm extends StatefulWidget {
  final void Function() reloadState;

  const AddExpenseForm({Key? key, required this.reloadState}) : super(key: key);

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final costController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'New Expense',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  MoneyInputField(label: 'Cost', controller: costController),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context);

                              try {
                                final db = DatabaseService();
                                await db.openDb();
                                await db
                                    .insertExpense(Expense(
                                        id: null,
                                        name: nameController.text,
                                        cost: double.parse(costController.text),
                                        active: true));
                              } catch (ex) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Failed to add expense: ' +
                                          ex.toString())),
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
