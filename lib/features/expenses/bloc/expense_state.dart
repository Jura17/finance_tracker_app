import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/core/utils/expense_category.dart';

class ExpenseState {
  final ExpenseCategory? selectedCategory;
  final List<Expense> filteredExpenses;
  final String? message;

  ExpenseState({
    this.selectedCategory,
    this.filteredExpenses = const [],
    this.message,
  });

  // used to overwrite state
  ExpenseState copyWith({
    ExpenseCategory? selectedCategory,
    List<Expense>? filteredExpenses,
    String? message,
  }) {
    return ExpenseState(
      selectedCategory: selectedCategory,
      filteredExpenses: filteredExpenses ?? this.filteredExpenses,
      message: message ?? this.message,
    );
  }
}
