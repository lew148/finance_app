import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Calc extends StatefulWidget {
  const Calc({Key? key}) : super(key: key);

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Calculator',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
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
                  labelText: 'Amount',
                  isDense: true,
                  prefixIcon: Text('£'),
                  prefixIconConstraints: BoxConstraints(minWidth: 20, minHeight: 0),
                ),
              ),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                  labelText: 'Savings %',
                  isDense: true,
                  suffix: Text('%'),
                  suffixIconConstraints: BoxConstraints(minWidth: 20, minHeight: 0),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
