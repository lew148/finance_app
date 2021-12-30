class BudgetedExpense {
  int? id;
  int expenseId;
  int budgetEventId;
  String name;
  double cost;

  BudgetedExpense({
    required this.id,
    required this.expenseId,
    required this.budgetEventId,
    required this.name,
    required this.cost,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'expenseId': expenseId,
      'budgetEventId': budgetEventId,
      'name': name,
      'cost': cost
    };
  }
}
