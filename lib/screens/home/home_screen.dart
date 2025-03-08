import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/manager/user/user_cubit.dart';

import 'package:personal_finance/resources/icons_manager.dart';
import 'package:personal_finance/resources/routes_manager.dart';
import 'package:personal_finance/resources/strings_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.watch<UserCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text("${AppStrings.welcome} ${userCubit.state.name} "),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.person),
            onPressed: () {
              Navigator.pushNamed(context, Routes.setUpRoute);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 20),
            _buildSpendingChart(),
            const SizedBox(height: 20),
            _buildSectionTitle(AppStrings.recentTransactions),
            _buildTransactionList(),
            const SizedBox(height: 20),
            _buildSectionTitle(AppStrings.budgetOverview),
            _buildBudgetProgress(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      color: Colors.red,
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.totalBalance,
                style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 8),
            Text("\$5,250.00",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildSpendingChart() {
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
                          switch (value.toInt()) {
                            case 0:
                              return const Text(AppStrings.sat);
                            case 1:
                              return const Text(AppStrings.sun);
                            case 2:
                              return const Text(AppStrings.mon);
                            case 3:
                              return const Text(AppStrings.tue);
                            case 4:
                              return const Text(AppStrings.wed);
                            case 5:
                              return const Text(AppStrings.thu);
                            case 6:
                              return const Text(AppStrings.fri);
                            default:
                              return const Text("");
                          }
                        },
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 50),
                        const FlSpot(1, 80),
                        const FlSpot(2, 40),
                        const FlSpot(3, 90),
                        const FlSpot(4, 30),
                        const FlSpot(5, 100),
                        const FlSpot(6, 60),
                      ],
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTransactionList() {
    return Column(
      children: List.generate(3, (index) => _buildTransactionItem(index)),
    );
  }

  Widget _buildTransactionItem(int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ListTile(
        leading: const Icon(AppIcons.shoppingCart, color: Colors.red),
        title: Text("${AppStrings.transactions} ${index + 1}"),
        subtitle: const Text("02 March 2025"),
        trailing: const Text("- \$50.00",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildBudgetProgress() {
    return Column(
      children: [
        _buildBudgetItem("Food", 70),
        _buildBudgetItem("Transport", 40),
        _buildBudgetItem("Entertainment", 90),
      ],
    );
  }

  Widget _buildBudgetItem(String category, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress / 100,
          backgroundColor: Colors.grey[300],
          color: progress > 80 ? Colors.red : Colors.green,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
