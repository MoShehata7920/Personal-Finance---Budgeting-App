import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/app/shared_preferences.dart';
import 'package:personal_finance/models/budget_model.dart';
import 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit() : super(BudgetInitial()) {
    loadBudgetData();
  }

  Future<void> loadBudgetData() async {
    try {
      BudgetModel? budget = await SharedPreferencesHelper.getBudgetData();

      if (budget != null) {
        emit(BudgetLoaded(budget));
      } else {
        emit(BudgetLoaded(
            BudgetModel(totalBudget: 0, totalSpent: 0, categories: [])));
      }
    } catch (e) {
      emit(BudgetError("Failed to load budget data"));
    }
  }

  Future<void> updateBudget(BudgetModel budget) async {
    try {
      await SharedPreferencesHelper.saveBudgetData(budget);
      emit(BudgetLoaded(budget));
    } catch (e) {
      emit(BudgetError("Failed to update budget data"));
    }
  }

  Future<void> resetBudget() async {
    try {
      await SharedPreferencesHelper.clearBudgetData();
      emit(BudgetLoaded(
          BudgetModel(totalBudget: 0, totalSpent: 0, categories: [])));
    } catch (e) {
      emit(BudgetError("Failed to reset budget"));
    }
  }

  void deleteCategory(String categoryName) async {
    try {
      if (state is BudgetLoaded) {
        final budget = (state as BudgetLoaded).budget;
        final updatedCategories =
            budget.categories.where((c) => c.name != categoryName).toList();

        final updatedBudget = BudgetModel(
          totalBudget: budget.totalBudget,
          totalSpent: budget.totalSpent,
          categories: updatedCategories,
        );

        await SharedPreferencesHelper.saveBudgetData(updatedBudget);
        emit(BudgetLoaded(updatedBudget));
      }
    } catch (e) {
      emit(BudgetError("Failed to delete category"));
    }
  }
}
