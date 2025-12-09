import 'package:flutter/material.dart';

import 'package:budget_master/core/resources/routes_manager.dart';
import 'package:budget_master/core/resources/strings_manager.dart';
import 'package:budget_master/features/settings/presentation/view/widgets/category_screen_body.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.categories),
        centerTitle: true,
      ),
      body: const CategoryScreenBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addCategoryRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
