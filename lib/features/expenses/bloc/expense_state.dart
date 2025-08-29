import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/core/utils/expense_category.dart';

enum ExpenseStatus { initial, loading, success, failure }

class ExpenseState {
  final ExpenseStatus status;
  final ExpenseCategory? selectedCategory;
  final ExpenseCategory newExpenseCategory;
  final List<Expense> filteredExpenses;
  final String? message;
  final double sumExpenseAmounts;

  ExpenseState({
    this.status = ExpenseStatus.initial,
    this.selectedCategory,
    this.newExpenseCategory = ExpenseCategory.clothing,
    this.filteredExpenses = const [],
    this.message,
    this.sumExpenseAmounts = 0,
  });

  // used to overwrite state
  ExpenseState copyWith({
    ExpenseStatus? status,
    ExpenseCategory? selectedCategory,
    ExpenseCategory? newExpenseCategory,
    List<Expense>? filteredExpenses,
    String? message,
    double? sumExpenseAmounts,
  }) {
    return ExpenseState(
      status: status ?? this.status,
      selectedCategory: selectedCategory,
      newExpenseCategory: newExpenseCategory ?? this.newExpenseCategory,
      filteredExpenses: filteredExpenses ?? this.filteredExpenses,
      message: message ?? this.message,
      sumExpenseAmounts: sumExpenseAmounts ?? this.sumExpenseAmounts,
    );
  }
}
