import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/manager/budget_cubit/budget_cubit.dart';
import 'package:personal_finance/manager/budget_cubit/budget_state.dart';
import 'package:personal_finance/models/category_model.dart';
import 'package:personal_finance/resources/routes_manager.dart';
import 'package:personal_finance/resources/strings_manager.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.categories),
        centerTitle: true,
      ),
      body: BlocBuilder<BudgetCubit, BudgetState>(
        builder: (context, state) {
          if (state is BudgetInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BudgetLoaded) {
            if (state.budget.categories.isEmpty) {
              return const Center(child: Text(AppStrings.noCategoryAvailable));
            }
            return ListView.builder(
              itemCount: state.budget.categories.length,
              itemBuilder: (context, index) {
                final category = state.budget.categories[index];
                return _buildBudgetCategory(category, context);
              },
            );
          } else if (state is BudgetError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addCategoryRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBudgetCategory(CategoryBudget category, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: SizedBox(
          width: 50,
          height: 50,
          child: Icon(category.icon),
        ),
        title: Text(category.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(
            "${AppStrings.spent} \$${category.spentAmount.toStringAsFixed(2)} / \$${category.totalAmount.toStringAsFixed(2)}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            context.read<BudgetCubit>().deleteCategory(category.name);
          },
        ),
      ),
    );
  }
}
