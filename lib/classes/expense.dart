class Expense {
  final int id;
  String name;
  double cost;

  Expense({required this.id, required this.name, required this.cost});

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      name: json['name'],
      cost: json['cost'],
    );
  }
}

class ExpenseHelper {
  static List<Expense> getTestExpenses() => [
        Expense(id: 1, name: 'Dance', cost: 12.89),
        Expense(id: 2, name: 'Phone', cost: 45.00),
        Expense(id: 3, name: 'Car', cost: 180.99),
        Expense(id: 4, name: 'Fairly long name for an expense', cost: 123233145.98),
        Expense(id: 5, name: 'Thing', cost: 45.98),
        Expense(id: 6, name: 'Another Thing', cost: 456.01),
      ];
}
