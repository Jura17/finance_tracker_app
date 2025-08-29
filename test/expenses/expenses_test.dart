import 'package:bloc_test/bloc_test.dart';
import 'package:finance_tracker_app/core/utils/expense_category.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_bloc.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_event.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_state.dart';
import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/core/utils/mockdata.dart';
import 'package:finance_tracker_app/features/expenses/data/repos/database_repo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ExpenseBloc bloc;
  late DatabaseRepo repo;

  setUp(() {
    repo = DatabaseRepo();
    bloc = ExpenseBloc(repo);
  });

  test('App starts filled with mockdata', () {
    expect(bloc.state.filteredExpenses, hasLength(mockData.length));
    expect(bloc.state.selectedCategory, null);
  });

  blocTest<ExpenseBloc, ExpenseState>(
    'adds an expense successfully',
    build: () => bloc, // create a new bloc instance
    act: (bloc) {
      // send a new event to the bloc
      final expense = Expense(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: DateTime.now(),
        category: ExpenseCategory.grocery,
        description: 'Äpfel',
        amount: 2.99,
      );
      bloc.add(AddExpense(expense));
    },
    expect: () => [
      isA<ExpenseState>().having((state) => state.message, 'message', 'Eintrag wurde erstellt.'),
    ],
  );

  blocTest<ExpenseBloc, ExpenseState>(
    'removes an existing expense',
    build: () => bloc,
    seed: () {
      // make sure that there is some data that can be removed
      final expense = Expense(
        id: '1',
        date: DateTime.now(),
        category: ExpenseCategory.grocery,
        description: 'Apples',
        amount: 2.99,
      );
      repo.addExpense(expense);
      return bloc.state.copyWith(filteredExpenses: repo.expenses);
    },
    act: (bloc) => bloc.add(RemoveExpense('1')),
    expect: () => [isA<ExpenseState>().having((state) => state.message, 'message', 'Eintrag wurde gelöscht.')],
  );

  blocTest<ExpenseBloc, ExpenseState>(
    'filters expenses by category',
    build: () => bloc,
    seed: () {
      repo.addExpense(Expense(
          id: '1', date: DateTime.now(), category: ExpenseCategory.grocery, description: 'Apples', amount: 2.99));
      repo.addExpense(Expense(
          id: '2', date: DateTime.now(), category: ExpenseCategory.restaurant, description: 'Lunch', amount: 10.0));
      return bloc.state.copyWith(filteredExpenses: repo.expenses);
    },
    act: (bloc) => bloc.add(FilterExpenses(ExpenseCategory.grocery)),
    expect: () => [isA<ExpenseState>().having((state) => state.filteredExpenses.length, 'filteredExpenses length', 1)],
  );
}
