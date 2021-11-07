import 'package:finance_app/classes/expense.dart';
import 'package:finance_app/db/database_service.dart';
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
    costController.dispose();
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
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  TextFormField(
                    controller: costController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[^0][0-9]*(.[1-9]{0,2}$)*$')),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        try {
                          final newText = newValue.text;
                          if (newText.isEmpty) return oldValue;
                          double.parse(newText);
                          return newValue;
                          // ignore: empty_catches
                        } catch (e) {}
                        return oldValue;
                      }),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Cost',
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
                                const SnackBar(
                                    content: Text('Adding expense to db...')),
                              );

                              try {
                                final db = DatabaseService();
                                await db.openDb();
                                await db
                                    .insertExpense(Expense(
                                        id: null,
                                        name: nameController.text,
                                        cost: double.parse(costController.text),
                                        active: true))
                                    .then((v) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Successfully added expense!')),
                                  );

                                  widget.reloadState();
                                });
                              } catch (ex) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Failed to add expense: ' +
                                          ex.toString())),
                                );
                              }
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
