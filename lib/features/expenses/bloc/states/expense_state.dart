import 'package:finance_tracker_app/features/expenses/utils/expense_category.dart';

class ExpenseState {
  final ExpenseCategory? selectedCategory;
  final String? message;

  ExpenseState({this.selectedCategory, this.message});

  // used to overwrite state
  ExpenseState copyWith({
    ExpenseCategory? selectedCategory,
    String? message,
  }) {
    return ExpenseState(
      selectedCategory: selectedCategory,
      message: message,
    );
  }
}
