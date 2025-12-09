import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_master/core/app/shared_preferences.dart';
import 'package:budget_master/features/budget/data/models/budget_model.dart';
import 'package:budget_master/features/transactions/data/models/transactions_model.dart';
import 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit() : super(BudgetInitial()) {
    loadBudgetData();
  }

  Future<void> loadBudgetData() async {
    try {
      BudgetModel? budget = await SharedPreferencesHelper.getBudgetData();
      budget ??= BudgetModel(
          totalBudget: 0, totalSpent: 0, categories: [], transactions: []);
      emit(BudgetLoaded(budget));
    } catch (e) {
      emit(BudgetError("Failed to load budget data: ${e.toString()}"));
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

  void addTransaction(TransactionModel transaction) async {
    try {
      if (state is BudgetLoaded) {
        final budget = (state as BudgetLoaded).budget;

        final updatedCategories = budget.categories.map((category) {
          if (category.name == transaction.categoryName) {
            final newSpentAmount = category.spentAmount + transaction.amount;
            return category.copyWith(spentAmount: newSpentAmount);
          }
          return category;
        }).toList();

        final updatedBudget = budget.copyWith(
          totalSpent: budget.totalSpent + transaction.amount,
          categories: updatedCategories,
          transactions: [...budget.transactions, transaction],
        );

        emit(BudgetLoaded(updatedBudget));
        await SharedPreferencesHelper.saveBudgetData(updatedBudget);
      }
    } catch (e) {
      emit(BudgetError("Failed to add transaction"));
    }
  }

  void deleteTransaction(String transactionId) async {
    try {
      if (state is BudgetLoaded) {
        final budget = (state as BudgetLoaded).budget;

        final updatedTransactions =
            budget.transactions.where((t) => t.id != transactionId).toList();

        final updatedTotalSpent =
            updatedTransactions.fold<double>(0.0, (sum, t) => sum + t.amount);

        final updatedCategories = budget.categories.map((category) {
          final removedAmount = budget.transactions
              .where((t) =>
                  t.id == transactionId && t.categoryName == category.name)
              .fold<double>(0.0, (sum, t) => sum + t.amount);

          return category.copyWith(
            spentAmount: category.spentAmount - removedAmount,
          );
        }).toList();

        final updatedBudget = budget.copyWith(
          totalSpent: updatedTotalSpent,
          transactions: updatedTransactions,
          categories: updatedCategories,
        );

        await SharedPreferencesHelper.saveBudgetData(updatedBudget);
        emit(BudgetLoaded(updatedBudget));
      }
    } catch (e) {
      emit(BudgetError("Failed to delete transaction"));
    }
  }

  void updateTransaction(TransactionModel updatedTransaction) async {
    try {
      if (state is BudgetLoaded) {
        final budget = (state as BudgetLoaded).budget;
        final updatedTransactions = budget.transactions.map((t) {
          return t.id == updatedTransaction.id ? updatedTransaction : t;
        }).toList();

        final updatedTotalSpent =
            updatedTransactions.fold<double>(0.0, (sum, t) => sum + t.amount);

        final updatedCategories = budget.categories.map((category) {
          final newSpent = updatedTransactions
              .where((t) => t.categoryName == category.name)
              .fold<double>(0.0, (sum, t) => sum + t.amount);
          return category.copyWith(spentAmount: newSpent);
        }).toList();

        final updatedBudget = budget.copyWith(
          totalSpent: updatedTotalSpent,
          transactions: updatedTransactions,
          categories: updatedCategories,
        );

        await SharedPreferencesHelper.saveBudgetData(updatedBudget);
        emit(BudgetLoaded(updatedBudget));
      }
    } catch (e) {
      emit(BudgetError("Failed to update transaction"));
    }
  }
}
