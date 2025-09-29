import 'package:flutter/material.dart';

import 'package:personal_finance/core/resources/strings_manager.dart';
import 'package:personal_finance/core/widgets/banner_ads.dart';
import 'package:personal_finance/features/budget/presentation/view/widgets/budget_screen_body.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.budget),
        centerTitle: true,
      ),
      body: const BudgetScreenBody(),
      bottomNavigationBar: const BannerAdWidget(),
    );
  }
}
