import 'dart:async';
import 'package:flutter/material.dart';
import 'package:budget_master/core/app/shared_preferences.dart';
import 'package:budget_master/core/resources/routes_manager.dart';
import 'package:budget_master/features/splash/presentation/widgets/splash_screen_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashScreenBody());
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    bool isDataAvailable = await SharedPreferencesHelper.isUserDataAvailable();

    if (!mounted) return;

    if (isDataAvailable) {
      Navigator.pushReplacementNamed(context, Routes.navBarRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.setUpRoute);
    }
  }
}
