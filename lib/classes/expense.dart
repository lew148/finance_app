class Expense {
  int? id;
  String name;
  double cost;
  bool active;

  Expense({required this.id, required this.name, required this.cost, required this.active});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'cost': cost};
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      name: json['name'],
      cost: json['cost'],
      active: json['active']
    );
  }
}

class ExpenseHelper {
  static List<Expense> getTestExpenses() => [
        Expense(id: 1, name: 'Dance', cost: 12.89, active: true),
        Expense(id: 2, name: 'Phone', cost: 45.00, active: true),
        Expense(id: 3, name: 'Car', cost: 180.99, active: true),
        Expense(
            id: 4, name: 'Fairly long name for an expense', cost: 123233145.98, active: true),
        Expense(id: 5, name: 'Thing', cost: 45.98, active: true),
        Expense(id: 6, name: 'Another Thing', cost: 456.01, active: true),
      ];
}
