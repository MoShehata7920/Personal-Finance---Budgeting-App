import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/features/budget/presentation/manager/budget_cubit.dart';
import 'package:personal_finance/features/budget/presentation/manager/budget_state.dart';
import 'package:personal_finance/core/resources/strings_manager.dart';
import 'package:personal_finance/features/nav_bar/presentation/views/nav_bar.dart';
import 'package:personal_finance/features/set_up_user/presentation/view/set_up_screen_view.dart';
import 'package:personal_finance/features/settings/presentation/view/about_screen_view.dart';
import 'package:personal_finance/features/settings/presentation/view/budget_control_screen_view.dart';
import 'package:personal_finance/features/settings/presentation/view/add_category_screen.dart';
import 'package:personal_finance/features/settings/presentation/view/category_screen.dart';
import 'package:personal_finance/features/splash/presentation/splash_screen_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String navBarRoute = '/navBarRoute';
  static const String setUpRoute = '/setUpRoute';
  static const String categoryRoute = '/categoryRoute';
  static const String addCategoryRoute = '/addCategoryRoute';
  static const String budgetControlRoute = '/budgetControlRoute';
  static const String aboutRoute = '/aboutRoute';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case Routes.navBarRoute:
        return MaterialPageRoute(builder: (context) => const BottomNavBar());

      case Routes.setUpRoute:
        return MaterialPageRoute(builder: (context) => const SetUpScreen());

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

      case Routes.aboutRoute:
        return MaterialPageRoute(builder: (context) => const AboutScreen());

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
