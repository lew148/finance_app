import 'package:finance_app/classes/budget_event.dart';
import 'package:finance_app/classes/expense.dart';
import 'package:finance_app/db/database_service.dart';
import 'package:finance_app/pages/budgetView/budget_view.dart';
import 'package:finance_app/shared/forms/money_input_field.dart';
import 'package:flutter/material.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddBudgetEventForm extends StatefulWidget {
  final void Function() reloadState;

  const AddBudgetEventForm({Key? key, required this.reloadState})
      : super(key: key);

  @override
  State<AddBudgetEventForm> createState() => _AddBudgetEventFormState();
}

class _AddBudgetEventFormState extends State<AddBudgetEventForm> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();
  late Future<List<Expense>> _allExpenses;
  List<Expense>? _selectedExpenses;

  @override
  void initState() {
    super.initState();
    setInitState();
  }

  void setInitState() async {
    Future<List<Expense>> expenses = getExpenses();

    setState(() {
      _allExpenses = expenses;
    });
  }

  Future<List<Expense>> getExpenses() async {
    final db = DatabaseService();
    await db.openDb();
    return await db.getExpenses();
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);

      try {
        final db = DatabaseService();
        await db.openDb();
        await db
            .insertBudgetEvent(
          BudgetEvent(
            id: null,
            income: double.parse(_valueController.text),
            date: DateTime.now(),
          ),
          _selectedExpenses!,
        )
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
    return FutureBuilder(
        future: _allExpenses,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done ||
              !snapshot.hasData) {
            return Container();
          }

          List<Expense> data = snapshot.data;
          _selectedExpenses ??= data;

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
                      MoneyInputField(
                          label: 'Income', controller: _valueController),
                      MultiSelectDialogField(
                        items: data
                            .map((e) => MultiSelectItem(e, e.name))
                            .toList(),
                        initialValue: _selectedExpenses,
                        listType: MultiSelectListType.CHIP,
                        onConfirm: (List<Expense> values) {
                          setState(() {
                            _selectedExpenses = values;
                          });
                        },
                      ),
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
        });
  }
}
