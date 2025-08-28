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
      final updatedFiltered = repo.filterByCategory(event.expense.category);

      emit(
        state.copyWith(
          filteredExpenses: updatedFiltered,
          selectedCategory: state.selectedCategory,
          message: "Eintrag wurde erstellt.",
        ),
      );
    });

    // REMOVE
    on<RemoveExpense>((event, emit) {
      repo.removeExpense(event.id);
      final updatedFiltered = repo.filterByCategory(state.selectedCategory);

      emit(state.copyWith(
        message: "Eintrag wurde gelöscht.",
        filteredExpenses: updatedFiltered,
      ));
    });

    // FILTER
    on<FilterExpenses>((event, emit) {
      final filtered = repo.filterByCategory(event.category);

      emit(state.copyWith(
        selectedCategory: event.category,
        filteredExpenses: filtered,
        message: "",
      ));
    });

    // CHANGE CATEGORY IN NEW EXPENSE MODAL
    on<NewExpenseCategoryChanged>((event, emit) {
      final updatedCategory = event.category;
      emit(state.copyWith(newExpenseCategory: updatedCategory));
    });

    on<CalculateSum>((event, emit) {
      final List<double> expenseAmounts = state.filteredExpenses.map((expense) => expense.amount).toList();
      var sum = expenseAmounts.fold(0.0, (sum, amount) => (sum + amount));
      emit(state.copyWith(sumExpenseAmounts: sum));
    });

    // load all expenses when bloc gets created
    add(LoadExpenses());
  }
}
