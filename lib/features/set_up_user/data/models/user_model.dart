import 'package:budget_master/core/resources/assets_manager.dart';
import 'package:budget_master/core/resources/strings_manager.dart';

class UserModel {
  final String name;
  final String imagePath;

  UserModel({required this.name, required this.imagePath});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imagePath': imagePath,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? AppStrings.guest,
      imagePath: json['imagePath'] ?? AppImages.appLogo,
    );
  }
}
