import 'package:finance_tracker_app/core/app_theme.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_bloc.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_event.dart';
import 'package:finance_tracker_app/features/expenses/data/repos/database_repo.dart';
import 'package:finance_tracker_app/features/expenses/presentation/screens/expenses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseRepo = DatabaseRepo();

  runApp(MainApp(databaseRepo: databaseRepo));
}

class MainApp extends StatelessWidget {
  final DatabaseRepo databaseRepo;
  const MainApp({super.key, required this.databaseRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = ExpenseBloc(databaseRepo);
        // not using context.read() here because bloc is not done being built yet
        bloc.add(LoadExpenses());

        return bloc;
      },
      child: MaterialApp(
        home: ExpensesScreen(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
      ),
    );
  }
}
