import 'package:finance_app/pages/homePage/budgeting/budgeting.dart';
import 'package:finance_app/pages/homePage/expenses/expenses.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
          return _selectedIndex == 0 ? const Expenses() : const Budgeting();
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.money), label: "Expenses"),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "Budgeting"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped
      ),
    );
  }
}