import 'package:finance_tracker_app/features/expenses/data/models/expense_category.dart';
import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/features/expenses/data/provider/local_database.dart';

class DatabaseRepo {
  LocalDatabase localDatabase;

  DatabaseRepo(this.localDatabase);

  void addExpense(Expense expense) {
    localDatabase.addExpense(expense);
  }

  void removeExpense(String id) {
    localDatabase.removeExpense(id);
  }

  List<Expense> filterByCategory(ExpenseCategory category) {
    List<Expense> allExpenses = localDatabase.expenses;
    return allExpenses.where((expense) => expense.category == category).toList();
  }
}
