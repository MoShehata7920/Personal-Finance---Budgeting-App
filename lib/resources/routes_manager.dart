import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/manager/budget_cubit/budget_cubit.dart';
import 'package:personal_finance/manager/budget_cubit/budget_state.dart';
import 'package:personal_finance/resources/strings_manager.dart';
import 'package:personal_finance/screens/nav_bar/nav_bar.dart';
import 'package:personal_finance/screens/set_up/set_up_screen.dart';
import 'package:personal_finance/screens/settings/sub_settings_screens/budget_control/budget_control_screen.dart';
import 'package:personal_finance/screens/settings/sub_settings_screens/category_screen/add_category_screen/add_category_screen.dart';
import 'package:personal_finance/screens/settings/sub_settings_screens/category_screen/category_screen.dart';
import 'package:personal_finance/screens/splash/splash_screen.dart';

class Routes {
  static const String splashRoute = '/';
  static const String navBarRoute = '/navBarRoute';
  static const String setUpRoute = '/setUpRoute';
  static const String categoryRoute = '/categoryRoute';
  static const String addCategoryRoute = '/addCategoryRoute';
  static const String budgetControlRoute = '/budgetControlRoute';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case Routes.navBarRoute:
        return MaterialPageRoute(builder: (context) => const BottomNavBar());

      case Routes.setUpRoute:
        return MaterialPageRoute(builder: (context) => const SetupScreen());

      case Routes.categoryRoute:
        return MaterialPageRoute(builder: (context) => const CategoryScreen());

      case Routes.addCategoryRoute:
        return MaterialPageRoute(
          builder: (context) {
            final budgetCubit = context.read<BudgetCubit>();
            return BlocProvider.value(
              value: budgetCubit,
              child: AddCategoryScreen(
                onCategoryAdded: (newCategory) {
                  final currentBudget =
                      (budgetCubit.state as BudgetLoaded).budget;
                  final updatedBudget = currentBudget.copyWith(
                    categories: [...currentBudget.categories, newCategory],
                  );
                  budgetCubit.updateBudget(updatedBudget);
                },
              ),
            );
          },
        );

      case Routes.budgetControlRoute:
        return MaterialPageRoute(
            builder: (context) => const BudgetControlScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteTitle),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
