import 'package:finance_app/classes/budget_event.dart';
import 'package:finance_app/classes/budgeted_expense.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../classes/expense.dart';

class DatabaseService {
  late Future<Database> database;

  Future<void> createDb(Database db, version) async {
    Batch batch = db.batch();

    batch.execute('''
      CREATE TABLE expenses(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        cost REAL,
        active INTEGER DEFAULT 1
      );
      ''');

    batch.execute('''
      CREATE TABLE budgetEvents(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        income REAL NOT NULL,
        savings REAL,
        date TEXT NOT NULL,
        expensesTotal REAL
      );
      ''');

    batch.execute('''
      CREATE TABLE budgetedExpenses(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        expenseId INTEGER NOT NULL,
        budgetEventId INTEGER NOT NULL,
        name TEXT,
        cost REAL,
        FOREIGN KEY(expenseId) REFERENCES expenses(id),
        FOREIGN KEY(budgetEventId) REFERENCES budgetEvents(id)
      );
      ''');

    await batch.commit();
  }

  void upgradeDb(db, oldVersion, newVersion) {
    switch (oldVersion) {
      case 1:
        break;
    }
  }

  Future<void> openDb() async {
    // await deleteDatabase('finance_app.db');
    database = openDatabase(join(await getDatabasesPath(), 'finance_app.db'),
        onCreate: createDb, onUpgrade: upgradeDb, version: 1);
  }

  Future<void> insertExpense(Expense expense) async {
    final db = await database;
    await db.insert('expenses', expense.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Expense>> getExpenses({bool activeOnly = false}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = activeOnly
        ? await db.query('expenses', where: "active = 1")
        : await db.query('expenses');

    return List.generate(
        maps.length,
        (i) => Expense(
            id: maps[i]['id'],
            name: maps[i]['name'],
            cost: maps[i]['cost'],
            active: maps[i]['active'] == 1 // saved in db as integer (0 or 1)
            ));
  }

  Future<void> deleteExpense(int id) async {
    final db = await database;
    await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<BudgetEvent>> getBudgetEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('budgetEvents');
    return List.generate(
        maps.length,
        (i) => BudgetEvent(
              id: maps[i]['id'],
              income: maps[i]['income'],
              savings: maps[i]['savings'],
              date: DateTime.parse(maps[i]['date']),
              expensesTotal: maps[i]['expensesTotal'],
            ));
  }

  Future<BudgetEvent> getBudgetEvent(int? id) async {
    final db = await database;
    return getBudgetEventDb(db, id);
  }

  Future<BudgetEvent> getBudgetEventDb(Database db, int? id) async {
    final List<Map<String, dynamic>> maps =
        await db.query('budgetEvents', where: "id = " + id.toString());
    final Map<String, dynamic> first = maps[0];
    return BudgetEvent(
      id: id,
      income: first['income'],
      savings: first['savings'],
      date: DateTime.parse(first['date']),
      expensesTotal: first['expensesTotal'],
    );
  }

  Future<int> insertBudgetEvent(BudgetEvent budgetEvent) async {
    final db = await database;

    var activeExpenses = await getExpenses(activeOnly: true);
    budgetEvent.expensesTotal =
        activeExpenses.fold(0, (prev, e) => prev! + e.cost);

    var newBudgetEventId = await db.insert(
      'budgetEvents',
      budgetEvent.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    for (var ae in activeExpenses) {
      await insertBudgetedExpense(
          db,
          BudgetedExpense(
              id: null,
              expenseId: ae.id!,
              budgetEventId: newBudgetEventId,
              name: ae.name,
              cost: ae.cost));
    }

    return newBudgetEventId;
  }

  Future<void> deleteBudgetEvent(int id) async {
    final db = await database;

    var budgetedExpenses = await getBudgetedExpensesDb(db, id);

    for (var be in budgetedExpenses) {
      await db.delete('budgetedExpenses', where: 'id = ?', whereArgs: [be.id]);
    }

    await db.delete(
      'budgetEvents',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> addSavingsToBudgetEvent(
      int budgetEventId, double savings) async {
    final db = await database;
    final BudgetEvent existingBudgetEvent =
        await getBudgetEventDb(db, budgetEventId);
    existingBudgetEvent.savings = savings;
    await db.update(
      'budgetEvents',
      existingBudgetEvent.toMap(),
      where: 'id = ?',
      whereArgs: [existingBudgetEvent.id],
    );
  }

  Future<List<BudgetedExpense>> getBudgetedExpenses(int budgetedEventId) async {
    final db = await database;
    return getBudgetedExpensesDb(db, budgetedEventId);
  }

  Future<List<BudgetedExpense>> getBudgetedExpensesDb(
      Database db, int budgetedEventId) async {
    final List<Map<String, dynamic>> maps = await db.query('budgetedExpenses',
        where: "budgetEventId = " + budgetedEventId.toString());
    return List.generate(
        maps.length,
        (i) => BudgetedExpense(
              id: maps[i]['id'],
              expenseId: maps[i]['expenseId'],
              budgetEventId: maps[i]['budgetEventId'],
              name: maps[i]['name'],
              cost: maps[i]['cost'],
            ));
  }

  Future<void> insertBudgetedExpense(
      Database db, BudgetedExpense budgetedExpense) async {
    await db.insert(
      'budgetedExpenses',
      budgetedExpense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
