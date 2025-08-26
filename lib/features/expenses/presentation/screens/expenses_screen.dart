import 'package:finance_tracker_app/core/app_colors.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_bloc.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_event.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_state.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/category_dropdown.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/expense_card.dart';
import 'package:finance_tracker_app/core/utils/expense_category.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/new_expense_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ausgaben-Tracker",
          style: TextStyle(color: AppColors.lightForegroundText),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<ExpenseBloc, ExpenseState>(
            listener: (context, state) {
              if (state.message != null && state.message!.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                    duration: Duration(milliseconds: 1500),
                  ),
                );
              }
            },
            builder: (context, state) {
              final filteredExpenses = state.filteredExpenses;

              return Column(
                spacing: 20,
                children: [
                  // Category selection
                  CategoryDropdown(
                    selectedCategory: state.selectedCategory,
                    onCategoryChanged: (value) {
                      context.read<ExpenseBloc>().add(FilterExpenses(value));
                    },
                    isForFiltering: true,
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
                        // Expense cards
                        : ListView.builder(
                            itemCount: filteredExpenses.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: ExpenseCard(filteredExpenses: filteredExpenses, index: index),
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
