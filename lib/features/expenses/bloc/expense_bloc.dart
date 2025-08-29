import 'package:finance_tracker_app/features/expenses/bloc/expense_event.dart';
import 'package:finance_tracker_app/features/expenses/bloc/expense_state.dart';
import 'package:finance_tracker_app/features/expenses/data/repos/database_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final DatabaseRepo repo;

  ExpenseBloc(this.repo) : super(ExpenseState()) {
    // LOAD
    on<LoadExpenses>((event, emit) async {
      try {
        emit(state.copyWith(status: ExpenseStatus.loading));
        await repo.loadExpenses();
        final allExpenses = repo.expenses;
        // TODO: put CalculateSum logic into all the events (add, remove, etc.) so there is no need for separate event
        add(CalculateSum());
        emit(state.copyWith(status: ExpenseStatus.success, filteredExpenses: allExpenses, selectedCategory: null));
      } catch (e) {
        emit(state.copyWith(status: ExpenseStatus.failure));
      }
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
  }
}
