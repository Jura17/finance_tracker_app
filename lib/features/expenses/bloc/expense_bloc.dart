import 'package:finance_tracker_app/features/expenses/bloc/expense_event.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_state.dart';
import 'package:finance_tracker_app/features/expenses/data/repos/database_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final DatabaseRepo repo;

  ExpenseBloc(this.repo) : super(ExpenseState()) {
    // LOAD
    on<LoadExpenses>((event, emit) {
      final allExpenses = repo.expenses;
      emit(state.copyWith(filteredExpenses: allExpenses, selectedCategory: null));
    });

    // ADD
    on<AddExpense>((event, emit) {
      repo.addExpense(event.expense);
      emit(state.copyWith(message: "Eintrag wurde erstellt."));
    });

    // REMOVE
    on<RemoveExpense>((event, emit) {
      repo.removeExpense(event.id);
      emit(state.copyWith(message: "Eintrag wurde gelöscht."));
    });

    // FILTER
    on<FilterExpenses>((event, emit) {
      final filtered = repo.filterByCategory(event.category);
      emit(state.copyWith(
        selectedCategory: event.category,
        filteredExpenses: filtered,
      ));
    });

    // load all expenses when bloc gets created
    add(LoadExpenses());
  }
}
