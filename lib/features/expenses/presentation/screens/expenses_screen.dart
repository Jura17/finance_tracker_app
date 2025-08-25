import 'package:finance_tracker_app/features/expenses/bloc/events/expense_event.dart';
import 'package:finance_tracker_app/features/expenses/bloc/states/expense_state.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/category_dropdown.dart';
import 'package:finance_tracker_app/features/expenses/utils/expense_category.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/new_expense_modal.dart';
import 'package:finance_tracker_app/features/expenses/utils/truncate_decimals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ausgaben-Tracker")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<ExpenseBloc, ExpenseState>(
            listener: (context, state) {
              if (state.message != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message!)));
              }
            },
            builder: (context, state) {
              final repo = context.read<ExpenseBloc>().repo;
              var filteredExpenses = repo.filterByCategory(state.selectedCategory);

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CategoryDropdown(
                        selectedCategory: state.selectedCategory,
                        onCategoryChanged: (value) {
                          context.read<ExpenseBloc>().add(FilterExpenses(value));
                        },
                        isForFiltering: true,
                      )
                    ],
                  ),
                  Expanded(
                    child: filteredExpenses.isEmpty
                        ? Center(
                            child: Text(
                              state.selectedCategory == null
                                  ? "Keine Ausgaben vorhanden"
                                  : "Keine ${categoryLabels[state.selectedCategory]}ausgaben vorhanden",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          )
                        : ListView.builder(
                            itemCount: filteredExpenses.length,
                            itemBuilder: (BuildContext context, int index) {
                              final dateFormat = DateFormat('dd.MM.yyyy, HH:mm');
                              final formattedDate = dateFormat.format(filteredExpenses[index].date);
                              final truncatedValue = truncateTo2Decimals(filteredExpenses[index].amount);

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Card(
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
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return NewExpenseModal();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
