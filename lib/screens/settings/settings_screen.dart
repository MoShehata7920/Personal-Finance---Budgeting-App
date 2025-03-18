import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/manager/budget_cubit/budget_cubit.dart';
import 'package:personal_finance/manager/theme_cubit/theme_cubit.dart';
import 'package:personal_finance/manager/user/user_cubit.dart';
import 'package:personal_finance/resources/icons_manager.dart';
import 'package:personal_finance/resources/routes_manager.dart';
import 'package:personal_finance/resources/strings_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.watch<UserCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(File(userCubit.state.imagePath)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      userCubit.state.name,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          _buildSettingsTile(
            icon: AppIcons.mode,
            title: AppStrings.darkMode,
            trailing: Switch(
                value: context.watch<ThemeCubit>().state == ThemeMode.dark,
                onChanged: (val) {
                  context.read<ThemeCubit>().toggleTheme();
                }),
          ),
          const Divider(),
          _buildSettingsTile(
            icon: AppIcons.budget,
            title: AppStrings.budget,
            onTap: () {
              Navigator.pushNamed(context, Routes.budgetControlRoute);
            },
          ),
          const Divider(),
          _buildSettingsTile(
            icon: AppIcons.category,
            title: AppStrings.category,
            onTap: () {
              Navigator.pushNamed(context, Routes.categoryRoute);
            },
          ),
          const Divider(),
          _buildSettingsTile(
            icon: AppIcons.info,
            title: AppStrings.aboutApp,
            onTap: () {
              Navigator.pushNamed(context, Routes.aboutRoute);
            },
          ),
          ListTile(
            leading: const Icon(AppIcons.logout, color: Colors.red),
            title: const Text(AppStrings.logOut,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                )),
            onTap: () {
              context.read<UserCubit>().clearUserData();
              context.read<BudgetCubit>().resetBudget();
              Navigator.pushReplacementNamed(context, Routes.setUpRoute);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
      {required IconData icon,
      required String title,
      Widget? trailing,
      VoidCallback? onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, size: 28),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
