import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/core/resources/icons_manager.dart';
import 'package:personal_finance/core/resources/routes_manager.dart';
import 'package:personal_finance/core/resources/strings_manager.dart';
import 'package:personal_finance/features/budget/presentation/manager/budget_cubit.dart';
import 'package:personal_finance/features/settings/presentation/manager/theme_cubit.dart';
import 'package:personal_finance/features/settings/presentation/view/widgets/settings_tile.dart';
import 'package:personal_finance/features/set_up_user/presentation/manager/user_cubit.dart';

class SettingsScreenBody extends StatelessWidget {
  const SettingsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.watch<UserCubit>();

    return ListView(
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
        SettingsTile(
          icon: AppIcons.mode,
          title: AppStrings.darkMode,
          trailing: Switch(
              value: context.watch<ThemeCubit>().state == ThemeMode.dark,
              onChanged: (val) {
                context.read<ThemeCubit>().toggleTheme();
              }),
        ),
        const Divider(),
        SettingsTile(
          icon: AppIcons.budget,
          title: AppStrings.budget,
          onTap: () {
            Navigator.pushNamed(context, Routes.budgetControlRoute);
          },
        ),
        const Divider(),
        SettingsTile(
          icon: AppIcons.category,
          title: AppStrings.category,
          onTap: () {
            Navigator.pushNamed(context, Routes.categoryRoute);
          },
        ),
        const Divider(),
        SettingsTile(
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
    );
  }
}
