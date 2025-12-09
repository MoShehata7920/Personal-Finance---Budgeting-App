import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_master/core/resources/icons_manager.dart';
import 'package:budget_master/core/resources/strings_manager.dart';
import 'package:budget_master/features/budget/presentation/manager/budget_cubit.dart';
import 'package:budget_master/features/category/data/models/category_model.dart';

class BudgetCategoryWidget extends StatelessWidget {
  final CategoryBudget category;

  const BudgetCategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
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
          icon: const Icon(AppIcons.delete, color: Colors.red),
          onPressed: () {
            context.read<BudgetCubit>().deleteCategory(category.name);
          },
        ),
      ),
    );
  }
}
