import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/settings/settings_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.md),
              SettingsSection(
                title: 'Account',
                children: [
                  SettingsTile(
                    icon: Icons.person,
                    title: 'Edit Profile',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.editProfile);
                    },
                  ),
                  SettingsTile(
                    icon: Icons.medical_information,
                    title: 'Medical Information',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.medicalInformation);
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: 'Preferences',
                children: [
                  SettingsTile(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.notificationPreferences);
                    },
                  ),
                  SettingsSwitchTile(
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    subtitle: 'Enable dark theme',
                    value: false,
                    onChanged: (value) {},
                  ),
                  SettingsTile(
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: 'English',
                    onTap: () {},
                  ),
                ],
              ),
              SettingsSection(
                title: 'Privacy & Security',
                children: [
                  SettingsTile(
                    icon: Icons.privacy_tip,
                    title: 'Privacy Settings',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.privacySecurity);
                    },
                  ),
                  SettingsTile(
                    icon: Icons.security,
                    title: 'Security',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.privacySecurity);
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: 'Support',
                children: [
                  SettingsTile(
                    icon: Icons.help,
                    title: 'Help & Support',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.helpSupport);
                    },
                  ),
                  SettingsTile(
                    icon: Icons.info,
                    title: 'About RapidCare',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.about);
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: 'Account Actions',
                children: [
                  SettingsTile(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: AppColors.errorRed),
            ),
          ),
        ],
      ),
    );
  }
}
