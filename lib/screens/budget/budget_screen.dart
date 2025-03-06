import 'package:flutter/material.dart';
import 'package:personal_finance/resources/icons_manager.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(AppStrings.totalBudget,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$5000",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                        Text("Spent: \$3200",
                            style: TextStyle(fontSize: 16, color: Colors.red)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: 3200 / 5000, // Example Progress
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(AppStrings.categoryBudgets,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildBudgetCategory("Food", 500, 350),
                  _buildBudgetCategory("Shopping", 700, 500),
                  _buildBudgetCategory("Rent", 1500, 1500),
                  _buildBudgetCategory("Entertainment", 400, 250),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //todo: Navigate to add/edit budget screen
        },
        child: const Icon(AppIcons.add),
      ),
    );
  }

  Widget _buildBudgetCategory(String title, double total, double spent) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: SizedBox(
          width: 50,
          height: 50,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: spent / total,
                backgroundColor: Colors.grey[300],
                color: spent == total ? Colors.red : Colors.green,
                strokeWidth: 5,
              ),
              Center(
                child: Text("${((spent / total) * 100).toInt()}%",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        title: Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(
            "${AppStrings.spent} \$${spent.toStringAsFixed(2)} / \$${total.toStringAsFixed(2)}"),
      ),
    );
  }
}
