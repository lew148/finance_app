import 'package:finance_app/classes/budget_event.dart';

class TestData {
  static List<BudgetEvent> getTestBudgetEvents() {
    return [
      BudgetEvent(id: 0, income: 2000, date: DateTime(2021, 11, 12), expensesTotal: 404.76),
      BudgetEvent(id: 1, income: 1897.98, date: DateTime(2022, 11, 12), expensesTotal: 404.76),
      BudgetEvent(id: 2, income: 4567.87, date: DateTime(2021, 10, 6), expensesTotal: 404.76),
      BudgetEvent(id: 3, income: 45676545678.98, date: DateTime(2021, 4, 26), expensesTotal: 404.76),
      BudgetEvent(id: 4, income: 3456.98, date: DateTime(2021, 2, 5), expensesTotal: 404.76),
      BudgetEvent(id: 5, income: 2001.57, date: DateTime(2021, 9, 2), expensesTotal: 404.76),
      BudgetEvent(id: 6, income: 5467.89, date: DateTime(1999, 3, 4), expensesTotal: 404.76),
    ];
  }
}
