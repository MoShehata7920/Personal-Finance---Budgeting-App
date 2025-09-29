import 'package:flutter/material.dart';

import 'package:personal_finance/core/resources/strings_manager.dart';
import 'package:personal_finance/features/settings/presentation/view/widgets/about_screen_body.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.aboutApp),
        centerTitle: true,
      ),
      body: const AboutScreenBody(),
    );
  }
}
