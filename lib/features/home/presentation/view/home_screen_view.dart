import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:personal_finance/core/resources/strings_manager.dart';
import 'package:personal_finance/features/home/presentation/view/widgets/home_screen_body.dart';
import 'package:personal_finance/features/set_up_user/presentation/manager/user_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.watch<UserCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text("${AppStrings.welcome} ${userCubit.state.name}"),
      ),
      body: const HomeScreenBody(),
    );
  }
}
