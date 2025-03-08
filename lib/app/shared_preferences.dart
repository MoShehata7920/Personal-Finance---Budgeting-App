import 'package:personal_finance/resources/assets_manager.dart';
import 'package:personal_finance/resources/strings_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:personal_finance/models/user_model.dart';

class SharedPreferencesHelper {
  static const String userKey = 'userData';

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
}
