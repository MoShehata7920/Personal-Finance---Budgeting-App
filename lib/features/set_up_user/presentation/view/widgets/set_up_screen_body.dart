import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_finance/core/resources/icons_manager.dart';
import 'package:personal_finance/core/resources/routes_manager.dart';
import 'package:personal_finance/core/resources/strings_manager.dart';
import 'package:personal_finance/features/set_up_user/data/models/user_model.dart';
import 'package:personal_finance/features/set_up_user/presentation/manager/user_cubit.dart';

class SetUpScreenBody extends StatefulWidget {
  const SetUpScreenBody({super.key});

  @override
  State<SetUpScreenBody> createState() => _SetUpScreenBodyState();
}

class _SetUpScreenBodyState extends State<SetUpScreenBody> {
  final TextEditingController nameController = TextEditingController();
  File? _image;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void saveUserData() async {
    if (nameController.text.isEmpty || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.pleaseEnterName)),
      );
      return;
    }

    final userCubit = context.read<UserCubit>();

    try {
      await userCubit.updateUserName(nameController.text);
      await userCubit.updateUserImage(_image!.path);

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.navBarRoute);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.failedSAvingDatA)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<UserCubit, UserModel>(
            builder: (context, state) {
              return GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : (state.imagePath.isNotEmpty
                          ? FileImage(File(state.imagePath))
                          : null),
                  child: _image == null && state.imagePath.isEmpty
                      ? const Icon(AppIcons.camera, size: 50)
                      : null,
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: AppStrings.enterName),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: saveUserData,
            child: const Text(AppStrings.saveAndContinue),
          ),
        ],
      ),
    );
  }
}
