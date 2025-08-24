import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/features/expenses/utils/expense_category.dart';

class ExpenseState {
  final ExpenseCategory? selectedCategory;

  ExpenseState({this.selectedCategory});

  // used to overwrite state
  ExpenseState copyWith({
    List<Expense>? allExpenses,
    ExpenseCategory? selectedCategory,
  }) {
    return ExpenseState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
