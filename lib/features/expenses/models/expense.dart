import 'package:finance_tracker_app/features/expenses/models/category.dart';

class Expense {
  final DateTime date;
  final Category category;
  final String description;
  final double amount;

  Expense({
    required this.date,
    required this.category,
    required this.description,
    required this.amount,
  });
}
