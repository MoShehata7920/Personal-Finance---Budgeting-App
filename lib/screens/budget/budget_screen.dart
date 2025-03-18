import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/manager/budget_cubit/budget_cubit.dart';
import 'package:personal_finance/manager/budget_cubit/budget_state.dart';
import 'package:personal_finance/models/budget_model.dart';
import 'package:personal_finance/models/category_model.dart';
import 'package:personal_finance/models/transactions_model.dart';
import 'package:personal_finance/resources/strings_manager.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.budget),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<BudgetCubit, BudgetState>(
          builder: (context, state) {
            if (state is BudgetInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BudgetLoaded) {
              return _buildBudgetView(state.budget);
            } else if (state is BudgetError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildBudgetView(BudgetModel budget) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(AppStrings.totalBudget,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$${budget.totalBudget.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      Text(
                          "${AppStrings.spent} \$${budget.totalSpent.toStringAsFixed(2)}",
                          style:
                              const TextStyle(fontSize: 16, color: Colors.red)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: budget.totalBudget > 0
                        ? (budget.totalSpent / budget.totalBudget)
                            .clamp(0.0, 1.0)
                        : 0,
                    backgroundColor: Colors.grey[300],
                    color: budget.totalSpent / budget.totalBudget < 0.5
                        ? Colors.green
                        : budget.totalSpent / budget.totalBudget < 0.8
                            ? Colors.orange
                            : Colors.red,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(AppStrings.categoryBudgets,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: budget.categories.length,
            itemBuilder: (context, index) {
              final category = budget.categories[index];
              return _buildBudgetCategory(
                  category, budget.totalBudget, budget.transactions);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetCategory(CategoryBudget category, double overallBudget,
      List<TransactionModel> transactions) {
    final double progress =
        overallBudget > 0 ? (category.spentAmount / overallBudget) : 0;
    final int progressPercentage = (progress * 100).toInt();

    final List<TransactionModel> categoryTransactions =
        transactions.where((t) => t.categoryName == category.name).toList();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ExpansionTile(
        leading: SizedBox(
          width: 50,
          height: 50,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                backgroundColor: Colors.grey[300],
                color: progress >= 1.0 ? Colors.red : Colors.green,
                strokeWidth: 5,
              ),
              Center(
                child: Text("$progressPercentage%",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        title: Text(category.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(
            "${AppStrings.spent} \$${category.spentAmount.toStringAsFixed(2)} / \$${category.totalAmount.toStringAsFixed(2)}"),
        children: categoryTransactions.isNotEmpty
            ? categoryTransactions.map((transaction) {
                return ListTile(
                  title: Text("\$${transaction.amount.toStringAsFixed(2)}"),
                  subtitle: Text(
                      "${transaction.date.toLocal()}${transaction.note != null ? " - ${transaction.note}" : ""}"),
                );
              }).toList()
            : [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(AppStrings.noTransactionsAvailable,
                      textAlign: TextAlign.center),
                )
              ],
      ),
    );
  }
}
