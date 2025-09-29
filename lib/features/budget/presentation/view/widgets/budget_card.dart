import 'package:flutter/material.dart';
import 'package:personal_finance/core/resources/strings_manager.dart';
import 'package:personal_finance/features/budget/presentation/view/widgets/budget_category.dart';
import 'package:personal_finance/features/budget/data/models/budget_model.dart';

class BudgetCard extends StatelessWidget {
  final BudgetModel budget;

  const BudgetCard({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
              return BudgetCategory(
                  category: category,
                  overallBudget: budget.totalBudget,
                  transactions: budget.transactions);
            },
          ),
        ],
      ),
    );
  }
}
