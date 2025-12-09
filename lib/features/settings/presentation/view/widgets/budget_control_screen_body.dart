import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_master/core/resources/icons_manager.dart';
import 'package:budget_master/core/resources/routes_manager.dart';
import 'package:budget_master/core/resources/strings_manager.dart';
import 'package:budget_master/features/budget/data/models/budget_model.dart';
import 'package:budget_master/features/budget/presentation/manager/budget_cubit.dart';
import 'package:budget_master/features/budget/presentation/manager/budget_state.dart';

class BudgetControlScreenBody extends StatefulWidget {
  const BudgetControlScreenBody({super.key});

  @override
  State<BudgetControlScreenBody> createState() =>
      _BudgetControlScreenBodyState();
}

class _BudgetControlScreenBodyState extends State<BudgetControlScreenBody> {
  final TextEditingController _budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<BudgetCubit, BudgetState>(
        builder: (context, state) {
          if (state is BudgetLoaded) {
            final budget = (state).budget;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _budgetController,
                  keyboardType: TextInputType.number,
                  onEditingComplete: () {
                    _updateBudget(context, budget);
                  },
                  decoration: InputDecoration(
                    labelText: AppStrings.enterBudget,
                    suffixIcon: IconButton(
                      icon: const Icon(AppIcons.add),
                      onPressed: () {
                        _updateBudget(context, budget);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  "${AppStrings.totalBudget}: \$${state.budget.totalBudget}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${AppStrings.totalSpent}: \$${state.budget.totalSpent}",
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),

                const SizedBox(height: 20),

                const Text(
                  AppStrings.categories,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: ListView.builder(
                    itemCount: state.budget.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.budget.categories[index];
                      return ListTile(
                        leading: Icon(category.icon),
                        title: Text(category.name),
                        trailing: IconButton(
                          icon: const Icon(AppIcons.delete, color: Colors.red),
                          onPressed: () {
                            context
                                .read<BudgetCubit>()
                                .deleteCategory(category.name);
                          },
                        ),
                      );
                    },
                  ),
                ),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.addCategoryRoute);
                    },
                    child: const Text(AppStrings.addCategory),
                  ),
                ),

                const SizedBox(height: 20),

                // Reset Budget Button
                Center(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      context.read<BudgetCubit>().resetBudget();
                    },
                    child: const Text(
                      AppStrings.resetBudget,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is BudgetError) {
            return Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red)),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _updateBudget(BuildContext context, BudgetModel budget) {
    final double? amount = double.tryParse(_budgetController.text);
    if (amount != null && amount > 0) {
      final updatedBudget = budget.copyWith(
        totalBudget: budget.totalBudget + amount,
      );
      context.read<BudgetCubit>().updateBudget(updatedBudget);
      _budgetController.clear();
    }
  }
}
