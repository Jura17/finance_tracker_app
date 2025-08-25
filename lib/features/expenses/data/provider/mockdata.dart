import 'package:finance_tracker_app/core/utils/expense_category.dart';
import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';

final List<Expense> mockData = [
  Expense(
    id: '1',
    date: DateTime.now(),
    category: ExpenseCategory.household,
    description: "Etwas Text über diese Ausgabe in der Kategorie 'Haushalt'",
    amount: 350.00,
  ),
  Expense(
    id: '2',
    date: DateTime.now(),
    category: ExpenseCategory.leisure,
    description: "Etwas Text über diese Ausgabe in der Kategorie 'Freizeit'",
    amount: 1.99,
  ),
  Expense(
    id: '3',
    date: DateTime.now(),
    category: ExpenseCategory.education,
    description: "Etwas Text über diese Ausgabe in der Kategorie 'Bildung'",
    amount: 26.99,
  ),
  Expense(
    id: '4',
    date: DateTime.now(),
    category: ExpenseCategory.clothing,
    description: "Etwas Text über diese Ausgabe in der Kategorie 'Kleidung'",
    amount: 39.95,
  ),
  Expense(
    id: '5',
    date: DateTime.now(),
    category: ExpenseCategory.phone,
    description: "Etwas Text über diese Ausgabe in der Kategorie 'Handy'",
    amount: 78.24,
  ),
];
