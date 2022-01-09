class BudgetEvent {
  int? id;
  double income;
  double? savings;
  DateTime date;
  double? expensesTotal;

  BudgetEvent({
    required this.id,
    required this.income,
    this.savings,
    required this.date,
    this.expensesTotal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'income': income,
      'savings': savings,
      'date': date.toString(),
      'expensesTotal': expensesTotal
    };
  }
}
