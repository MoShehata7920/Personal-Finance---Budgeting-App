import 'package:flutter/material.dart';
import 'package:budget_master/core/resources/assets_manager.dart';
import 'package:budget_master/core/resources/strings_manager.dart';
import 'package:budget_master/core/services/animation.dart';
import 'package:budget_master/core/services/utils.dart';

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;

    return Center(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.1),
          SizedBox(
            height: size.height * 0.4,
            child: Image.asset(AppImages.appLogo).animateOnPageLoad(
                msDelay: 150, dx: 0.0, dy: -200.0, showDelay: 900),
          ),
          Column(
            children: [
              SizedBox(height: size.height * 0.35),
              const Text(
                AppStrings.developedBy,
                style: TextStyle(
                  color: Color(0xFF00BCD4),
                  fontSize: 18,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).animateOnPageLoad(
                  msDelay: 300, dx: 0.0, dy: 70.0, showDelay: 300),
              const SizedBox(height: 10),
              const Text(
                AppStrings.mohamedShehata,
                style: TextStyle(
                  color: Color(0xFF707099),
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ).animateOnPageLoad(
                  msDelay: 300, dx: 0.0, dy: 70.0, showDelay: 300),
            ],
          ),
        ],
      ),
    );
  }
}
