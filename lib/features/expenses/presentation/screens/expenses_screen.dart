import 'package:finance_tracker_app/features/expenses/presentation/widgets/category_dropdown.dart';
import 'package:finance_tracker_app/features/expenses/utils/expense_category.dart';
import 'package:finance_tracker_app/features/expenses/data/provider/local_database.dart';
import 'package:finance_tracker_app/features/expenses/data/repos/database_repo.dart';
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
  ExpenseCategory? selectedCategory;
  var filteredExpenses = [];

  @override
  void initState() {
    super.initState();
    localDb.addMockData();
    repo = DatabaseRepo(localDb);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ausgaben-Tracker"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CategoryDropdown(
                    selectedCategory: selectedCategory,
                    onCategoryChanged: (value) {
                      selectedCategory = value;
                      setState(() {
                        filteredExpenses = repo.filterByCategory(selectedCategory);
                      });
                    },
                    isForFiltering: true,
                  )
                ],
              ),
              Expanded(
                child: filteredExpenses.isEmpty
                    ? Center(
                        child: Text(
                        "Keine ${categoryLabels[selectedCategory]}ausgaben vorhanden",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ))
                    : ListView.builder(
                        itemCount: filteredExpenses.length,
                        itemBuilder: (BuildContext context, int index) {
                          final dateFormat = DateFormat('dd.MM.yyyy, HH:mm');
                          final formattedDate = dateFormat.format(filteredExpenses[index].date);

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Card(
                              key: Key(filteredExpenses[index].id),
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
                                          "${filteredExpenses[index].amount.toStringAsFixed(2)} €",
                                          style: Theme.of(context).textTheme.headlineMedium,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              repo.removeExpense(filteredExpenses[index].id);
                                            });
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
                        }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return NewExpenseModal(repo: repo);
              },
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
