import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../classes/expense.dart';

class DatabaseService {
  late Future<Database> database;

  Future<void> createDb(Database db, version) => db.execute('CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, cost REAL)');

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

  Future<List<Expense>> getExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');
    return List.generate(
        maps.length,
        (i) => Expense(
            id: maps[i]['id'], name: maps[i]['name'], cost: maps[i]['cost']));
  }
}
