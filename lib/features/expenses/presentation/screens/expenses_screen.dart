import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/features/expenses/data/models/expense_category.dart';
import 'package:finance_tracker_app/features/expenses/data/provider/local_database.dart';
import 'package:finance_tracker_app/features/expenses/data/repos/database_repo.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/filter_dropdown.dart';
import 'package:finance_tracker_app/features/expenses/presentation/widgets/new_expense_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final LocalDatabase localDb = LocalDatabase();
  late DatabaseRepo repo;

  @override
  void initState() {
    super.initState();
    localDb.addMockData();
    repo = DatabaseRepo(localDb);
  }

  @override
  Widget build(BuildContext context) {
    var expenses = repo.expenses;

    return Scaffold(
      appBar: AppBar(
        title: Text("Ausgaben-Tracker"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [FilterDropdown()],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (BuildContext context, int index) {
                  final dateFormat = DateFormat('dd.MM.yyyy, HH:mm');
                  final formattedDate = dateFormat.format(expenses[index].date);

                  return Card(
                    key: Key(expenses[index].id),
                    color: Colors.white30,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${expenses[index].amount.toString()} €",
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    repo.removeExpense(expenses[index].id);
                                  });
                                },
                                icon: Icon(Icons.delete),
                              )
                            ],
                          ),
                          Text(categoryLabels[expenses[index].category].toString()),
                          Text(expenses[index].description),
                          Text(formattedDate),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return NewExpenseModal();
                });
            repo.addExpense(
              Expense(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  date: DateTime.now(),
                  category: ExpenseCategory.fitness,
                  description: "Test expense",
                  amount: 11.99),
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
