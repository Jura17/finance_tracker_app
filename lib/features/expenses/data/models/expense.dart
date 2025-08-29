import 'package:finance_tracker_app/core/utils/expense_category.dart';

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'category': category.toString(),
        'description': description,
        'amount': amount,
      };

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json['id'],
        date: DateTime.parse(json['date']),
        category: ExpenseCategory.values.firstWhere((category) => json['category'] == category.toString()),
        description: json['description'],
        amount: json['amount'],
      );
}
