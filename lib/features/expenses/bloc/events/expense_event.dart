import 'package:finance_tracker_app/features/expenses/bloc/states/expense_state.dart';
import 'package:finance_tracker_app/features/expenses/data/models/expense.dart';
import 'package:finance_tracker_app/features/expenses/data/repos/database_repo.dart';
import 'package:finance_tracker_app/features/expenses/utils/expense_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ExpenseEvent {}

class AddExpense extends ExpenseEvent {
  final Expense expense;
  AddExpense(this.expense);
}

class RemoveExpense extends ExpenseEvent {
  final String id;
  RemoveExpense(this.id);
}

class FilterExpenses extends ExpenseEvent {
  // if null -> show all categories
  final ExpenseCategory? category;
  FilterExpenses(this.category);
}

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final DatabaseRepo repo;

  ExpenseBloc(this.repo) : super(ExpenseState()) {
    // add
    on<AddExpense>((event, emit) {
      repo.addExpense(event.expense);
      emit(state.copyWith());
    });

    // remove
    on<RemoveExpense>((event, emit) {
      repo.removeExpense(event.id);
      emit(state.copyWith());
    });

    // filter
    on<FilterExpenses>((event, emit) {
      emit(state.copyWith(selectedCategory: event.category));
    });
  }
}
