import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:budget_master/features/budget/presentation/manager/budget_cubit.dart';
import 'package:budget_master/features/category/presentation/manager/category_cubit.dart';
import 'package:budget_master/features/settings/presentation/manager/theme_cubit.dart';
import 'package:budget_master/features/set_up_user/presentation/manager/user_cubit.dart';
import 'package:budget_master/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => BudgetCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
