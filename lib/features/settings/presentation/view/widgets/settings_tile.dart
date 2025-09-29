import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? trailing;
  final String title;
  final IconData icon;

  const SettingsTile(
      {super.key,
      this.onTap,
      this.trailing,
      required this.title,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, size: 28),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
