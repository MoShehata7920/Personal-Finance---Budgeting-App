import 'package:flutter/material.dart';
import 'package:budget_master/core/resources/assets_manager.dart';
import 'package:budget_master/core/resources/icons_manager.dart';
import 'package:budget_master/core/resources/strings_manager.dart';
import 'package:budget_master/core/services/functions.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreenBody extends StatelessWidget {
  const AboutScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(AppImages.appLogo),
          ),
          const SizedBox(height: 10),
          const Text(
            AppStrings.appName,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(AppStrings.appVersion,
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          const Text(
            AppStrings.appDescription,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 30),
          const Divider(),
          const ListTile(
            leading: Icon(AppIcons.person, color: Colors.blue),
            title: Text(AppStrings.developedBy),
            subtitle: Text(AppStrings.mohamedShehata),
          ),
          ListTile(
            leading: const Icon(AppIcons.email, color: Colors.green),
            title: const Text(AppStrings.contact),
            subtitle: const Text(AppStrings.myGmail),
            onTap: () {
              launchUrl(Uri(scheme: "mailto", path: AppStrings.myGmail));
            },
          ),
          ListTile(
            leading: const Icon(AppIcons.github),
            title: const Text(AppStrings.gitHub),
            subtitle: const Text(AppStrings.myGitHub),
            onTap: () {
              launchGitHubUrl();
            },
          ),
          ListTile(
            leading: const Icon(AppIcons.instagram),
            title: const Text(AppStrings.instagram),
            subtitle: const Text(AppStrings.myInstagram),
            onTap: () {
              launchInstagramUrl();
            },
          ),
          ListTile(
            leading: const Icon(AppIcons.facebook),
            title: const Text(AppStrings.facebook),
            subtitle: const Text(AppStrings.myFacebook),
            onTap: () {
              launchFacebookUrl();
            },
          ),
        ],
      ),
    );
  }
}
