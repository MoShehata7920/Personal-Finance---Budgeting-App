import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/core/resources/icons_manager.dart';
import 'package:personal_finance/core/resources/strings_manager.dart';
import 'package:personal_finance/core/services/functions.dart';
import 'package:personal_finance/features/budget/presentation/manager/budget_cubit.dart';
import 'package:personal_finance/features/category/data/models/category_model.dart';
import 'package:personal_finance/features/transactions/data/models/transactions_model.dart';

class BudgetCategory extends StatelessWidget {
  final CategoryBudget category;
  final double overallBudget;
  final List<TransactionModel> transactions;

  const BudgetCategory(
      {super.key,
      required this.category,
      required this.overallBudget,
      required this.transactions});

  @override
  Widget build(BuildContext context) {
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(AppIcons.edit, color: Colors.blue),
                        onPressed: () => editTransaction(context, transaction),
                      ),
                      IconButton(
                        icon: const Icon(AppIcons.delete, color: Colors.red),
                        onPressed: () {
                          context
                              .read<BudgetCubit>()
                              .deleteTransaction(transaction.id);
                        },
                      ),
                    ],
                  ),
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
