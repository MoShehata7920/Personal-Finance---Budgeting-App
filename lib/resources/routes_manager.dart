import 'package:flutter/material.dart';
import 'package:personal_finance/resources/strings_manager.dart';
import 'package:personal_finance/screens/nav_bar/nav_bar.dart';
import 'package:personal_finance/screens/set_up/set_up_screen.dart';
import 'package:personal_finance/screens/splash/splash_screen.dart';

class Routes {
  static const String splashRoute = '/';
  static const String navBarRoute = '/navBarRoute';
  static const String setUpRoute = '/setUpRoute';
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
