import 'package:finance_tracker_app/core/app_colors.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_bloc.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_event.dart';
import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/core/utils/expense_category.dart';
import 'package:finance_tracker_app/core/utils/truncate_decimals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.filteredExpenses, required this.index});

  final List<Expense> filteredExpenses;
  final int index;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy');
    final formattedDate = dateFormat.format(filteredExpenses[index].date);
    final truncatedValue = truncateTo2Decimals(filteredExpenses[index].amount);

    return Dismissible(
      key: ValueKey(filteredExpenses[index].id),
      onDismissed: (direction) {
        final expenseId = filteredExpenses[index].id;
        context.read<ExpenseBloc>().add(RemoveExpense(expenseId));
      },
      background: Container(color: Colors.red),
      child: Card(
        color: AppColors.containerColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 105,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      categoryLabels[filteredExpenses[index].category].toString(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(width: 50),
                    Text(formattedDate, style: Theme.of(context).textTheme.labelLarge),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          filteredExpenses[index].description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "${truncatedValue.toStringAsFixed(2)} €",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
