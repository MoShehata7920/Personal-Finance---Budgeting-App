import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'package:personal_finance/manager/budget_cubit/budget_cubit.dart';
import 'package:personal_finance/manager/budget_cubit/budget_state.dart';
import 'package:personal_finance/models/transactions_model.dart';
import 'package:personal_finance/resources/strings_manager.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.transactions)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<BudgetCubit, BudgetState>(
          builder: (context, state) {
            if (state is BudgetLoaded) {
              return _buildTransactionsUI(state);
            } else if (state is BudgetError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildTransactionsUI(BudgetLoaded state) {
    final budget = state.budget;
    return Column(
      children: [
        DropdownButton<String>(
          value: _selectedCategory,
          hint: const Text(AppStrings.selectCategory),
          isExpanded: true,
          items: budget.categories.map((category) {
            return DropdownMenuItem(
              value: category.name,
              child: Text(category.name),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
        ),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: AppStrings.amount),
        ),
        TextField(
          controller: _noteController,
          decoration: const InputDecoration(labelText: AppStrings.note),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final double? amount = double.tryParse(_amountController.text);
            final budgetState = context.read<BudgetCubit>().state;
            if (budgetState is BudgetLoaded &&
                _selectedCategory != null &&
                amount != null &&
                amount > 0) {
              final currentBudget = budgetState.budget;
              if (currentBudget.totalSpent + amount >
                  currentBudget.totalBudget) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(AppStrings.transactionExceedTotalBudget)),
                );
              } else {
                final transaction = TransactionModel(
                  id: const Uuid().v4(),
                  categoryName: _selectedCategory!,
                  amount: amount,
                  date: DateTime.now(),
                  note: _noteController.text,
                );
                context.read<BudgetCubit>().addTransaction(transaction);
                _amountController.clear();
                _noteController.clear();
                setState(() {
                  _selectedCategory = null;
                });
              }
            }
          },
          child: const Text(AppStrings.addTransaction),
        ),
        const SizedBox(height: 20),
        const Text(
          AppStrings.recentTransactions,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: budget.transactions.length,
            itemBuilder: (context, index) {
              final sortedTransactions = budget.transactions
                ..sort((a, b) => b.date.compareTo(a.date));

              final transaction = sortedTransactions[index];

              return ListTile(
                title: Text(transaction.categoryName),
                subtitle: Text(
                    "\$${transaction.amount.toStringAsFixed(2)} - ${transaction.date.toLocal()}"),
                trailing:
                    transaction.note != null ? Text(transaction.note!) : null,
              );
            },
          ),
        ),
      ],
    );
  }
}
