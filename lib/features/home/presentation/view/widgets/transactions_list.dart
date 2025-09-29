import 'package:flutter/material.dart';
import 'package:personal_finance/core/resources/icons_manager.dart';
import 'package:personal_finance/core/resources/strings_manager.dart';
import 'package:personal_finance/features/budget/data/models/budget_model.dart';

class TransactionsList extends StatelessWidget {
  final BudgetModel budget;

  const TransactionsList({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    if (budget.transactions.isEmpty) {
      return const Center(
        child: Text(
          AppStrings.noTransactionsAvailable,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    final sortedTransactions = budget.transactions
      ..sort((a, b) => b.date.compareTo(a.date));

    return Column(
      children: sortedTransactions.take(3).map((transaction) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: ListTile(
            leading: const Icon(AppIcons.shoppingCart, color: Colors.red),
            title: Text(transaction.categoryName),
            subtitle: Text(transaction.date.toLocal().toString().split(' ')[0]),
            trailing: Text(
              "- \$${transaction.amount.toStringAsFixed(2)}",
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
    );
    
  }
}
