import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_master/core/resources/strings_manager.dart';
import 'package:budget_master/features/budget/presentation/manager/budget_cubit.dart';
import 'package:budget_master/features/transactions/data/models/transactions_model.dart';
import 'package:url_launcher/url_launcher.dart';

void editTransaction(BuildContext context, TransactionModel transaction) {
  final TextEditingController amountController =
      TextEditingController(text: transaction.amount.toString());
  final TextEditingController noteController =
      TextEditingController(text: transaction.note ?? "");

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(AppStrings.editTransactions),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: AppStrings.amount),
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(labelText: AppStrings.note),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final double? newAmount = double.tryParse(amountController.text);
              if (newAmount != null && newAmount > 0) {
                final updatedTransaction = TransactionModel(
                  id: transaction.id,
                  categoryName: transaction.categoryName,
                  amount: newAmount,
                  date: transaction.date,
                  note: noteController.text,
                );
                context
                    .read<BudgetCubit>()
                    .updateTransaction(updatedTransaction);
                Navigator.pop(context);
              }
            },
            child: const Text(AppStrings.save),
          ),
        ],
      );
    },
  );
}

Future<void> launchGitHubUrl() async {
  final Uri gitHubUrl = Uri.parse(AppStrings.myGitHub);

  if (!await launchUrl(gitHubUrl)) {
    throw Exception('Could not launch $gitHubUrl');
  }
}

Future<void> launchInstagramUrl() async {
  final Uri instagramUrl = Uri.parse(AppStrings.myInstagram);

  if (!await launchUrl(instagramUrl)) {
    throw Exception('Could not launch $instagramUrl');
  }
}

Future<void> launchFacebookUrl() async {
  final Uri facebookUrl = Uri.parse(AppStrings.myFacebook);

  if (!await launchUrl(facebookUrl)) {
    throw Exception('Could not launch $facebookUrl');
  }
}
