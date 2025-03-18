import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:personal_finance/resources/assets_manager.dart';
import 'package:personal_finance/resources/icons_manager.dart';
import 'package:personal_finance/resources/strings_manager.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.aboutApp),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                _launchGitHubUrl();
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.instagram),
              title: const Text(AppStrings.instagram),
              subtitle: const Text(AppStrings.myInstagram),
              onTap: () {
                _launchInstagramUrl();
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.facebook),
              title: const Text(AppStrings.facebook),
              subtitle: const Text(AppStrings.myFacebook),
              onTap: () {
                _launchFacebookUrl();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchGitHubUrl() async {
    final Uri gitHubUrl = Uri.parse(AppStrings.myGitHub);

    if (!await launchUrl(gitHubUrl)) {
      throw Exception('Could not launch $gitHubUrl');
    }
  }

  Future<void> _launchInstagramUrl() async {
    final Uri instagramUrl = Uri.parse(AppStrings.myInstagram);

    if (!await launchUrl(instagramUrl)) {
      throw Exception('Could not launch $instagramUrl');
    }
  }

  Future<void> _launchFacebookUrl() async {
    final Uri facebookUrl = Uri.parse(AppStrings.myFacebook);

    if (!await launchUrl(facebookUrl)) {
      throw Exception('Could not launch $facebookUrl');
    }
  }
}
