import 'package:flutter/material.dart';
import '../../constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text("Settings", style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("General"),
          _buildSettingTile(
            icon: Icons.language,
            title: "Language",
            trailing: Text(
              selectedLanguage,
              style: const TextStyle(color: Colors.grey),
            ),
            onTap: _showLanguageDialog,
          ),
          _buildSettingTile(
            icon: Icons.brightness_6,
            title: "Dark Mode",
            trailing: Switch(
              value: isDarkMode,
              activeColor: kPrimaryColor,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle("Account"),
          _buildSettingTile(
            icon: Icons.lock_outline,
            title: "Privacy Policy",
            onTap: () {
              // TODO: Open privacy policy
            },
          ),
          _buildSettingTile(
            icon: Icons.description_outlined,
            title: "Terms & Conditions",
            onTap: () {
              // TODO: Open terms & conditions
            },
          ),
          _buildSettingTile(
            icon: Icons.logout,
            title: "Log Out",
            titleColor: Colors.redAccent,
            iconColor: Colors.redAccent,
            onTap: () {
              // TODO: Replace with actual logout logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logged out")),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    Color? titleColor,
    Color? iconColor,
    Widget? trailing,
    VoidCallback? onTap, // dibuat opsional agar tidak error
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? kPrimaryColor),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: titleColor ?? Colors.black,
          ),
        ),
        trailing: trailing ?? const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Select Language"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text("English"),
              value: "English",
              groupValue: selectedLanguage,
              onChanged: (val) {
                setState(() {
                  selectedLanguage = val!;
                  Navigator.pop(context);
                });
              },
            ),
            RadioListTile<String>(
              title: const Text("Bahasa Indonesia"),
              value: "Bahasa Indonesia",
              groupValue: selectedLanguage,
              onChanged: (val) {
                setState(() {
                  selectedLanguage = val!;
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
