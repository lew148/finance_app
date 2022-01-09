import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleMonetaryInputForm extends StatefulWidget {
  final String title;
  final String fieldLabel;
  final String submitText;
  final void Function(GlobalKey<FormState> formKey, TextEditingController valueController) onSubmit;

  const SingleMonetaryInputForm({
    Key? key,
    required this.title,
    required this.fieldLabel,
    required this.submitText,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<SingleMonetaryInputForm> createState() =>
      _SingleMonetaryInputFormState();
}

class _SingleMonetaryInputFormState extends State<SingleMonetaryInputForm> {
  final _formKey = GlobalKey<FormState>();
  final valueController = TextEditingController();

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: valueController,
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
                    decoration: InputDecoration(
                      labelText: widget.fieldLabel,
                      isDense: true,
                      prefixIcon: const Text('£'),
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 20, minHeight: 0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: () => widget.onSubmit(_formKey, valueController),
                          child: Text(widget.submitText),
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