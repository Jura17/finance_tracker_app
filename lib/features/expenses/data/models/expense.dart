import 'package:finance_tracker_app/features/expenses/data/models/expense_category.dart';

class Expense {
  final String id;
  final DateTime date;
  final ExpenseCategory category;
  final String description;
  final double amount;

  Expense({
    required this.id,
    required this.date,
    required this.category,
    required this.description,
    required this.amount,
  });
}
