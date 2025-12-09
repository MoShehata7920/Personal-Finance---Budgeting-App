import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:budget_master/core/resources/strings_manager.dart';
import 'package:budget_master/features/budget/data/models/budget_model.dart';

class SpendingChart extends StatelessWidget {
  final BudgetModel budget;
  const SpendingChart({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
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
}
