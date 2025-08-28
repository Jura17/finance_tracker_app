import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/core/utils/expense_category.dart';

class ExpenseState {
  final ExpenseCategory? selectedCategory;
  final ExpenseCategory newExpenseCategory;
  final List<Expense> filteredExpenses;
  final String? message;

  ExpenseState({
    this.selectedCategory,
    this.newExpenseCategory = ExpenseCategory.clothing,
    this.filteredExpenses = const [],
    this.message,
  });

  // used to overwrite state
  ExpenseState copyWith({
    ExpenseCategory? selectedCategory,
    ExpenseCategory? newExpenseCategory,
    List<Expense>? filteredExpenses,
    String? message,
  }) {
    return ExpenseState(
      selectedCategory: selectedCategory,
      newExpenseCategory: newExpenseCategory ?? this.newExpenseCategory,
      filteredExpenses: filteredExpenses ?? this.filteredExpenses,
      message: message ?? this.message,
    );
  }
}
