import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/core/utils/expense_category.dart';

abstract class ExpenseEvent {}

class LoadExpenses extends ExpenseEvent {}

class AddExpense extends ExpenseEvent {
  final Expense expense;
  AddExpense(this.expense);
}

class RemoveExpense extends ExpenseEvent {
  final String id;
  RemoveExpense(this.id);
}

class FilterExpenses extends ExpenseEvent {
  // if null -> show all categories
  final ExpenseCategory? category;
  FilterExpenses(this.category);
}

class NewExpenseCategoryChanged extends ExpenseEvent {
  final ExpenseCategory category;
  NewExpenseCategoryChanged(this.category);
}

class CalculateSum extends ExpenseEvent {}
