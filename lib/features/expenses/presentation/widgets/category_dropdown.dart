import 'package:finance_tracker_app/core/utils/expense_category.dart';
import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    this.isForFiltering = false,
  });

  final ExpenseCategory? selectedCategory;
  final ValueChanged<ExpenseCategory?>? onCategoryChanged;
  final bool isForFiltering;

  @override
  Widget build(BuildContext context) {
    final categoryValues = ExpenseCategory.values;

    final dropdownItems = <DropdownMenuEntry<ExpenseCategory?>>[
      // add a 'no filter'-option if widget is used for filtering in ExpensesScreen
      if (isForFiltering)
        DropdownMenuEntry(
          value: null,
          label: '- alle Ausgaben -',
        ),
      ...categoryValues.map((category) {
        // check if all categories have a matching label
        final label = categoryLabels[category];
        if (label == null) {
          throw Exception("Kein Label für Kategorie $category gefunden");
        }
        return DropdownMenuEntry(
          value: category,
          label: label,
        );
      })
    ];

    return DropdownMenu<ExpenseCategory?>(
      initialSelection: selectedCategory,
      dropdownMenuEntries: dropdownItems,
      onSelected: onCategoryChanged,
    );
  }
}
