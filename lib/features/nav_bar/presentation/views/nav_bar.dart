import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/features/nav_bar/presentation/manager/bottom_nav_cubit.dart';
import 'package:personal_finance/features/nav_bar/presentation/manager/bottom_nav_state.dart';
import 'package:personal_finance/core/resources/icons_manager.dart';
import 'package:personal_finance/core/resources/strings_manager.dart';
import 'package:personal_finance/features/budget/presentation/view/budget_screen_view.dart';
import 'package:personal_finance/features/home/presentation/view/home_screen_view.dart';
import 'package:personal_finance/features/settings/presentation/view/settings_screen_view.dart';
import 'package:personal_finance/features/transactions/presentation/view/transactions_screen_view.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: Builder(
        builder: (context) {
          final List<Widget> screens = [
            const HomeScreen(),
            const TransactionsScreen(),
            const BudgetScreen(),
            const SettingsScreen(),
          ];

          return BlocBuilder<BottomNavCubit, BottomNavState>(
            builder: (context, state) {
              return Scaffold(
                body: screens[state.selectedIndex],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: state.selectedIndex,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.red,
                  unselectedItemColor: Colors.grey,
                  items: _navBarItems(),
                  onTap: (index) =>
                      context.read<BottomNavCubit>().changeTab(index),
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _navBarItems() {
    return [
      _buildNavBarItem(AppIcons.home, AppStrings.home),
      _buildNavBarItem(AppIcons.transactions, AppStrings.transactions),
      _buildNavBarItem(AppIcons.budget, AppStrings.budget),
      _buildNavBarItem(AppIcons.settings, AppStrings.settings),
    ];
  }

  BottomNavigationBarItem _buildNavBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 30),
      label: label,
    );
  }
}
