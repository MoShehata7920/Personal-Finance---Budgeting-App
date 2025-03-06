import 'package:flutter/material.dart';
import 'package:personal_finance/resources/icons_manager.dart';
import 'package:personal_finance/resources/strings_manager.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.transactions),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.filter),
            onPressed: () {
              // TODO: Implement filter functionality
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildTransactionCard();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add transaction functionality
        },
        child: const Icon(AppIcons.add),
      ),
    );
  }

  Widget _buildTransactionCard() {
    return const Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(AppIcons.shoppingCart, size: 32),
        title: Text('Transaction Title'),
        subtitle: Text('12 Feb 2025'),
        trailing: Text(
          '- \$50.00',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
