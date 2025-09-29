import 'package:flutter/material.dart';

import 'package:personal_finance/core/resources/strings_manager.dart';
import 'package:personal_finance/features/settings/presentation/view/widgets/budget_control_screen_body.dart';

class BudgetControlScreen extends StatefulWidget {
  const BudgetControlScreen({super.key});

  @override
  State<BudgetControlScreen> createState() => _BudgetControlScreenState();
}

class _BudgetControlScreenState extends State<BudgetControlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.budget)),
      body: const BudgetControlScreenBody(),
    );
  }
}
