import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/core/resources/strings_manager.dart';
import 'package:personal_finance/features/budget/presentation/manager/budget_cubit.dart';
import 'package:personal_finance/features/budget/presentation/manager/budget_state.dart';
import 'package:personal_finance/features/settings/presentation/view/widgets/budget_category_widget.dart';

class CategoryScreenBody extends StatelessWidget {
  const CategoryScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetCubit, BudgetState>(
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
              return BudgetCategoryWidget(category: category);
            },
          );
        } else if (state is BudgetError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
