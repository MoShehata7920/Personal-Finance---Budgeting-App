import 'package:flutter/material.dart';

import 'package:budget_master/core/resources/strings_manager.dart';
import 'package:budget_master/core/widgets/banner_ads.dart';
import 'package:budget_master/features/transactions/presentation/view/widgets/transactions_screen_body.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.transactions)),
      body: const TransactionsScreenBody(),
      bottomNavigationBar: const BannerAdWidget(),
    );
  }
}
