import 'dart:convert';

import 'package:finance_tracker_app/core/utils/mockdata.dart';
import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsDb {
  late final Future<SharedPreferences> _prefsFuture;
  List<Expense> _localCopy = [];
  final String _expensesKey = 'expensesKey';

  SharedPrefsDb() {
    _prefsFuture = SharedPreferences.getInstance();
  }

  List<Expense> get expenses => _localCopy;

  Future<void> loadExpenses() async {
    final prefs = await _prefsFuture;
    final expensesString = prefs.getString(_expensesKey) ?? '';
    if (expensesString.isEmpty) return;
    final List<dynamic> decoded = jsonDecode(expensesString);
    final List<Expense> expensesList = decoded.map((e) => Expense.fromJson(e)).toList();
    _localCopy = expensesList;
  }

  Future<void> overrideExpenses() async {
    final prefs = await _prefsFuture;
    final localDbString = jsonEncode(_localCopy.map((e) => e.toJson()).toList());
    await prefs.setString(_expensesKey, localDbString);
  }

  void addExpense(Expense expense) {
    _localCopy.add(expense);
    overrideExpenses();
  }

  void removeExpense(String id) {
    _localCopy.removeWhere((expense) => expense.id == id);
    overrideExpenses();
  }

  void addMockData() {
    _localCopy.addAll(mockData);
    overrideExpenses();
  }

  void emptyDb() {
    _localCopy = [];
    overrideExpenses();
  }
}
