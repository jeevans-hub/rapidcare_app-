import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/settings/settings_widgets.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Security'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.md),
              SettingsTile(
                icon: Icons.lock,
                title: 'Change Password',
                subtitle: 'Update your password',
                onTap: () {},
              ),
              SettingsSwitchTile(
                icon: Icons.fingerprint,
                title: 'Biometric Login',
                subtitle: 'Use fingerprint or face recognition',
                value: false,
                onChanged: (value) {},
              ),
              SettingsTile(
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                subtitle: 'View our privacy policy',
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.description,
                title: 'Terms & Conditions',
                subtitle: 'View our terms and conditions',
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.data_usage,
                title: 'Data & Permissions',
                subtitle: 'Manage your data and app permissions',
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Your data is secure and encrypted. We do not share your personal information with third parties without your consent.',
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
