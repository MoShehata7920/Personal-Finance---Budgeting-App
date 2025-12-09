import 'package:flutter/material.dart';

import 'package:budget_master/core/resources/strings_manager.dart';
import 'package:budget_master/features/set_up_user/presentation/view/widgets/set_up_screen_body.dart';

class SetUpScreen extends StatelessWidget {
  const SetUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.setUpProfile)),
      body: const SetUpScreenBody(),
    );
  }
}
