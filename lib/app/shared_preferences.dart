import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:personal_finance/models/budget_model.dart';
import 'package:personal_finance/models/user_model.dart';
import 'package:personal_finance/resources/assets_manager.dart';
import 'package:personal_finance/resources/strings_manager.dart';

class SharedPreferencesHelper {
  static const String userKey = 'userData';
  static const String budgetKey = 'budgetData';

  static Future<void> saveUserData(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString(userKey, userJson);
  }

  static Future<UserModel> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(userKey);

    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    } else {
      return UserModel(name: AppStrings.guest, imagePath: AppImages.appLogo);
    }
  }

  static Future<bool> isUserDataAvailable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(userKey);

    if (userJson != null) {
      UserModel user = UserModel.fromJson(jsonDecode(userJson));

      if (user.name == AppStrings.guest ||
          user.imagePath == AppImages.appLogo) {
        return false;
      }

      return true;
    }

    return false;
  }

  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }

  static Future<void> saveBudgetData(BudgetModel budget) async {
    final prefs = await SharedPreferences.getInstance();
    String budgetJson = jsonEncode(budget.toJson());
    await prefs.setString(budgetKey, budgetJson);
  }

  static Future<BudgetModel?> getBudgetData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? budgetJson = prefs.getString(budgetKey);
    if (budgetJson != null) {
      return BudgetModel.fromJson(jsonDecode(budgetJson));
    }
    return null;
  }

  static Future<void> clearBudgetData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(budgetKey);
  }
}
