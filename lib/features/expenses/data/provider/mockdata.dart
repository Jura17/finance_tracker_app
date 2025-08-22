import 'package:finance_tracker_app/features/expenses/data/models/expense_category.dart';
import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';

final List<Expense> mockData = [
  Expense(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    date: DateTime.now(),
    category: ExpenseCategory.household,
    description: "Etwas Text über diese Ausgabe in der Kategorie 'Haushalt'",
    amount: 350.00,
  ),
  Expense(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    date: DateTime.now(),
    category: ExpenseCategory.leisure,
    description: "Etwas Text über diese Ausgabe in der Kategorie 'Freizeit'",
    amount: 1.99,
  ),
  Expense(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    date: DateTime.now(),
    category: ExpenseCategory.education,
    description: "Etwas Text über diese Ausgabe in der Kategorie 'Bildung'",
    amount: 26.99,
  ),
  Expense(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    date: DateTime.now(),
    category: ExpenseCategory.clothing,
    description: "Etwas Text über diese Ausgabe in der Kategorie 'Kleidung'",
    amount: 39.95,
  ),
  Expense(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    date: DateTime.now(),
    category: ExpenseCategory.phone,
    description: "Etwas Text über diese Ausgabe in der Kategorie 'Handy'",
    amount: 78.24,
  ),
];
