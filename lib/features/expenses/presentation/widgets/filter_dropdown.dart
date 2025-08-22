import 'package:finance_tracker_app/features/expenses/data/models/expense_category.dart';
import 'package:flutter/material.dart';

class FilterDropdown extends StatelessWidget {
  const FilterDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ExpenseCategory.values;

    final dropdownItems = <DropdownMenuEntry<ExpenseCategory?>>[
      const DropdownMenuEntry(
        value: null,
        label: '- alle Ausgaben -',
      ),
      ...categories.map((category) {
        // check if all categories have a matching label
        final label = categoryLabels[category];
        if (label == null) {
          throw Exception("Kein Label für Kategorie $category gefunden");
        }
        return DropdownMenuEntry(value: category, label: label);
      })
    ];

    return DropdownMenu(
      initialSelection: null,
      dropdownMenuEntries: dropdownItems,
    );
  }
}
