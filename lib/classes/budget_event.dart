class BudgetEvent {
  int? id;
  String income;
  DateTime date;

  BudgetEvent({required this.id, required this.income, required this.date});

  Map<String, dynamic> toMap() {
    return {'id': id, 'income': income, 'date': date};
  }
}
