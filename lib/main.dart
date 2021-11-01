import 'package:finance_app/pages/expenses/expenses.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Finance App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Finance App',
          style: TextStyle(fontSize: 25.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Builder(builder: (context) {
          return const Expenses();
        }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {}, child: const Icon(Icons.menu, size: 30.0)),
    );
  }
}
