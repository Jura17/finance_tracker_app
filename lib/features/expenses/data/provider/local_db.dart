import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/core/utils/mockdata.dart';

class LocalDatabase {
  List<Expense> expensesDB = [];

  List<Expense> get expenses => expensesDB;

  void addExpense(Expense expense) {
    expensesDB.add(expense);
  }

  void removeExpense(String id) {
    expensesDB.removeWhere((expense) => expense.id == id);
  }

  void addMockData() {
    expensesDB.addAll(mockData);
  }

  void emptyDb() {
    expensesDB = [];
  }
}
