import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/features/budget/presentation/manager/budget_cubit.dart';
import 'package:personal_finance/features/budget/presentation/manager/budget_state.dart';
import 'package:personal_finance/features/budget/presentation/view/widgets/budget_card.dart';

class BudgetScreenBody extends StatelessWidget {
  const BudgetScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<BudgetCubit, BudgetState>(
          builder: (context, state) {
            if (state is BudgetInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BudgetLoaded) {
              return BudgetCard(budget: state.budget);
            } else if (state is BudgetError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
