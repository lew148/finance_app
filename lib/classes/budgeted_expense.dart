class BudgetedExpense {
  int? id;
  int expenseId;
  int budgetEventId;

  BudgetedExpense(
      {required this.id, required this.expenseId, required this.budgetEventId});

  Map<String, dynamic> toMap() {
    return {'id': id, 'expenseId': expenseId, 'budgetEventId': budgetEventId};
  }
}
