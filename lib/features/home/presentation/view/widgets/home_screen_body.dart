import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/core/resources/strings_manager.dart';
import 'package:personal_finance/features/home/presentation/view/widgets/balance_card.dart';
import 'package:personal_finance/features/home/presentation/view/widgets/budget_progress.dart';
import 'package:personal_finance/features/home/presentation/view/widgets/section_title.dart';
import 'package:personal_finance/features/home/presentation/view/widgets/spending_chart.dart';
import 'package:personal_finance/features/home/presentation/view/widgets/transactions_list.dart';
import 'package:personal_finance/features/budget/presentation/manager/budget_cubit.dart';
import 'package:personal_finance/features/budget/presentation/manager/budget_state.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetCubit, BudgetState>(
      builder: (context, state) {
        if (state is BudgetLoaded) {
          final budget = state.budget;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                BalanceCard(
                  budget: budget,
                ),
                const SizedBox(height: 20),
                SpendingChart(budget: budget),
                const SizedBox(height: 20),
                const SectionTitle(title: AppStrings.recentTransactions),
                TransactionsList(budget: budget),
                const SizedBox(height: 20),
                const SectionTitle(title: AppStrings.budgetOverview),
                BudgetProgress(budget: budget),
              ],
            ),
          );
        } else if (state is BudgetError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
