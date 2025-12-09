import 'package:flutter/material.dart';
import 'package:budget_master/core/resources/strings_manager.dart';
import 'package:budget_master/features/budget/data/models/budget_model.dart';

class BalanceCard extends StatelessWidget {
  final BudgetModel budget;
  const BalanceCard({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppStrings.totalBalance,
                style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 8),
            Text("\$${budget.totalBudget.toStringAsFixed(2)}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
                "${AppStrings.spent} \$${budget.totalSpent.toStringAsFixed(2)}",
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
