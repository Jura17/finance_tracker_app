import 'package:finance_tracker_app/features/expenses/utils/expense_category.dart';
import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/features/expenses/data/provider/local_database.dart';

class DatabaseRepo {
  LocalDatabase localDatabase;

  DatabaseRepo(this.localDatabase);

  List<Expense> get expenses => localDatabase.expenses;

  void addExpense(Expense expense) {
    localDatabase.addExpense(expense);
  }

  void removeExpense(String id) {
    localDatabase.removeExpense(id);
  }

  List<Expense> filterByCategory(ExpenseCategory? category) {
    List<Expense> allExpenses = localDatabase.expenses;

    // if category input is null -> show all expenses, otherwise apply filter
    if (category == null) return allExpenses;
    return allExpenses.where((expense) => expense.category == category).toList();
  }
}
