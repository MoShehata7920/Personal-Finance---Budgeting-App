import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/manager/bottom_nav/bottom_nav_cubit.dart';
import 'package:personal_finance/manager/bottom_nav/bottom_nav_state.dart';
import 'package:personal_finance/resources/icons_manager.dart';
import 'package:personal_finance/resources/strings_manager.dart';
import 'package:personal_finance/screens/budget/budget_screen.dart';
import 'package:personal_finance/screens/home/home_screen.dart';
import 'package:personal_finance/screens/settings/settings_screen.dart';
import 'package:personal_finance/screens/transactions/transactions_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
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
            onTap: (index) => context.read<BottomNavCubit>().changeTab(index),
          ),
        );
      },
    );
    
  }
  List<BottomNavigationBarItem> _navBarItems() {
    return [
      _buildNavBarItem(AppIcons.home, AppStrings.home),
      _buildNavBarItem(AppIcons.transactions, AppStrings.transactions),
      _buildNavBarItem(AppIcons.budget, AppStrings.transactions),
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
