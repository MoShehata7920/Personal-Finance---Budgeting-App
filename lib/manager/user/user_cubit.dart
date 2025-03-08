import 'package:bloc/bloc.dart';
import 'package:personal_finance/app/shared_preferences.dart';
import 'package:personal_finance/models/user_model.dart';
import 'package:personal_finance/resources/assets_manager.dart';
import 'package:personal_finance/resources/strings_manager.dart';

class UserCubit extends Cubit<UserModel> {
  UserCubit()
      : super(UserModel(name: AppStrings.guest, imagePath: AppImages.appLogo)) {
    loadUserData();
  }

  Future<void> loadUserData() async {
    UserModel? user = await SharedPreferencesHelper.getUserData();
    emit(user);
  }

  Future<void> updateUserName(String name) async {
    UserModel updatedUser = UserModel(name: name, imagePath: state.imagePath);
    await SharedPreferencesHelper.saveUserData(updatedUser);
    emit(updatedUser);
  }

  Future<void> updateUserImage(String imagePath) async {
    UserModel updatedUser = UserModel(name: state.name, imagePath: imagePath);
    await SharedPreferencesHelper.saveUserData(updatedUser);
    emit(updatedUser);
  }

  Future<void> clearUserData() async {
    await SharedPreferencesHelper.clearUserData();
    emit(UserModel(name: "", imagePath: ""));
  }

  Future<void> checkUserData() async {
    bool isAvailable = await SharedPreferencesHelper.isUserDataAvailable();
    if (!isAvailable) {
      emit(UserModel(name: AppStrings.guest, imagePath: AppImages.appLogo));
    }
  }
}
