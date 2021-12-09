class BudgetEvent {
  int? id;
  double income;
  DateTime date;
  double? expensesTotal;

  BudgetEvent({required this.id, required this.income, required this.date, this.expensesTotal});

  Map<String, dynamic> toMap() {
    return {'id': id, 'income': income, 'date': date.toString(), 'expensesTotal': expensesTotal};
  }
}
