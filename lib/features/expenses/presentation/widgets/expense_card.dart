import 'package:finance_tracker_app/features/expenses/bloc/expense_bloc.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_event.dart';
import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/features/expenses/utils/expense_category.dart';
import 'package:finance_tracker_app/features/expenses/utils/truncate_decimals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.filteredExpenses, required this.index});

  final List<Expense> filteredExpenses;
  final int index;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy, HH:mm');
    final formattedDate = dateFormat.format(filteredExpenses[index].date);
    final truncatedValue = truncateTo2Decimals(filteredExpenses[index].amount);
    return Card(
      key: ValueKey(filteredExpenses[index].id),
      color: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$truncatedValue €",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                IconButton(
                  onPressed: () {
                    final expenseId = filteredExpenses[index].id;
                    context.read<ExpenseBloc>().add(RemoveExpense(expenseId));
                  },
                  icon: Icon(Icons.delete),
                )
              ],
            ),
            Text(categoryLabels[filteredExpenses[index].category].toString()),
            Text(filteredExpenses[index].description),
            Text(formattedDate),
          ],
        ),
      ),
    );
  }
}
