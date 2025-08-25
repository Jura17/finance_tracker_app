import 'package:finance_tracker_app/features/expenses/bloc/expense_bloc.dart';
import 'package:finance_tracker_app/features/expenses/data/repos/database_repo.dart';
import 'package:finance_tracker_app/features/expenses/presentation/screens/expenses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final databaseRepo = DatabaseRepo();
  runApp(
    BlocProvider(
      create: (context) => ExpenseBloc(databaseRepo),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ExpensesScreen());
  }
}
