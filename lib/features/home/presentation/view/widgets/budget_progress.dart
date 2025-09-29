import 'package:flutter/material.dart';
import 'package:personal_finance/features/budget/data/models/budget_model.dart';

class BudgetProgress extends StatelessWidget {
  final BudgetModel budget;

  const BudgetProgress({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: budget.categories.map((category) {
        double progress = budget.totalBudget > 0
            ? category.spentAmount / budget.totalBudget
            : 0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: Colors.grey[300],
              color: progress >= 1.0 ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 10),
          ],
        );
      }).toList(),
    );
  }
}
