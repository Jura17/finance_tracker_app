import 'package:finance_tracker_app/core/app_colors.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_bloc.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_event.dart';
import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/core/utils/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    super.key,
    required this.formKey,
    required this.selectedCategory,
    required this.descriptionCtrl,
    required this.amountCtrl,
  });

  final GlobalKey<FormState> formKey;
  final ExpenseCategory selectedCategory;
  final TextEditingController descriptionCtrl;
  final TextEditingController amountCtrl;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.darkBlue,
        backgroundColor: AppColors.lightBlue,
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          final expense = Expense(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            date: DateTime.now(),
            category: selectedCategory,
            description: descriptionCtrl.text,
            amount: double.parse(amountCtrl.text.replaceAll(',', '.')),
          );
          final previousCategory = context.read<ExpenseBloc>().state.selectedCategory;
          context.read<ExpenseBloc>().add(AddExpense(expense));
          Navigator.of(context).pop();
          context.read<ExpenseBloc>().add(FilterExpenses(previousCategory));
        }
      },
      child: Text("Eintrag anlegen"),
    );
  }
}
