import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance/manager/budget_cubit/budget_cubit.dart';
import 'package:personal_finance/manager/budget_cubit/budget_state.dart';
import 'package:personal_finance/manager/user/user_cubit.dart';
import 'package:personal_finance/models/budget_model.dart';
import 'package:personal_finance/resources/icons_manager.dart';
import 'package:personal_finance/resources/strings_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.watch<UserCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text("${AppStrings.welcome} ${userCubit.state.name}"),
      ),
      body: BlocBuilder<BudgetCubit, BudgetState>(
        builder: (context, state) {
          if (state is BudgetLoaded) {
            final budget = state.budget;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildBalanceCard(budget),
                  const SizedBox(height: 20),
                  _buildSpendingChart(budget),
                  const SizedBox(height: 20),
                  _buildSectionTitle(AppStrings.recentTransactions),
                  _buildTransactionList(budget),
                  const SizedBox(height: 20),
                  _buildSectionTitle(AppStrings.budgetOverview),
                  _buildBudgetProgress(budget),
                ],
              ),
            );
          } else if (state is BudgetError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildBalanceCard(BudgetModel budget) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppStrings.totalBalance,
                style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 8),
            Text("\$${budget.totalBudget.toStringAsFixed(2)}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
                "${AppStrings.spent} \$${budget.totalSpent.toStringAsFixed(2)}",
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildSpendingChart(BudgetModel budget) {
    List<String> last7Days = List.generate(7, (index) {
      return DateFormat('EEE')
          .format(DateTime.now().subtract(Duration(days: 6 - index)));
    });

    Map<String, double> dailySpending = {for (var day in last7Days) day: 0.0};

    for (var transaction in budget.transactions) {
      String day = DateFormat('EEE').format(transaction.date);
      if (dailySpending.containsKey(day)) {
        dailySpending[day] = (dailySpending[day] ?? 0) + transaction.amount;
      }
    }

    List<FlSpot> spendingData = [];
    for (int i = 0; i < last7Days.length; i++) {
      spendingData.add(FlSpot(i.toDouble(), dailySpending[last7Days[i]]!));
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.spendingTrend,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: false, reservedSize: 0),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < last7Days.length) {
                            return Text(last7Days[index]);
                          }
                          return const Text("");
                        },
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spendingData,
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                          show: true, color: Colors.red.withValues(alpha: 0.2)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList(BudgetModel budget) {
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

  Widget _buildBudgetProgress(BudgetModel budget) {
    return Column(
      children: budget.categories.map((category) {
        double progress = budget.totalBudget > 0
            ? category.spentAmount / budget.totalBudget
            : 0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: Colors.grey[300],
              color: progress >= 1.0 ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 10),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
