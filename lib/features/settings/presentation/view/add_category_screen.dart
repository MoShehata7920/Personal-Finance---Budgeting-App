import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_master/features/category/presentation/manager/category_cubit.dart';
import 'package:budget_master/features/category/data/models/category_model.dart';
import 'package:budget_master/core/resources/icons_manager.dart';
import 'package:budget_master/core/resources/strings_manager.dart';

class AddCategoryScreen extends StatelessWidget {
  final Function(CategoryBudget) onCategoryAdded;

  const AddCategoryScreen({super.key, required this.onCategoryAdded});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    return BlocProvider(
      create: (_) => CategoryCubit(),
      child: BlocBuilder<CategoryCubit, int?>(
        builder: (context, selectedIconIndex) {
          return Scaffold(
            appBar: AppBar(title: const Text(AppStrings.addCategory)),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 10,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        labelText: AppStrings.categoryName),
                  ),
                  const Text(AppStrings.selectIcon),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: AppIcons.categoriesIcons.length,
                      itemBuilder: (context, index) {
                        final iconData = AppIcons.categoriesIcons[index];
                        final isSelected = selectedIconIndex == index;

                        return GestureDetector(
                          onTap: () {
                            context
                                .read<CategoryCubit>()
                                .selectIcon(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue.withValues(alpha: 0.3)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(iconData, size: 40),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final selectedIndex = context.read<CategoryCubit>().state;

                      if (nameController.text.isNotEmpty &&
                          selectedIndex != null) {
                        final newCategory = CategoryBudget(
                          name: nameController.text,
                          totalAmount: 0,
                          spentAmount: 0,
                          iconIndex: selectedIndex,
                        );

                        onCategoryAdded(newCategory);
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(AppStrings.pleaseEnterNameAndIcon)),
                        );
                      }
                    },
                    child: const Text(AppStrings.addCategory),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
