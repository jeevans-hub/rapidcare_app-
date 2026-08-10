import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/settings/settings_widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About RapidCare'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.xl),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(AppRadius.large),
                ),
                child: const Icon(
                  Icons.local_hospital,
                  size: 60,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'RapidCare',
                style: AppTextStyles.headline.copyWith(
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Healthcare at your Fingertips',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondaryGrey,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLightGreyDark,
                  borderRadius: BorderRadius.circular(AppRadius.small),
                ),
                child: Text(
                  'Version 1.0.0',
                  style: AppTextStyles.caption,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              SettingsTile(
                icon: Icons.info,
                title: 'About RapidCare',
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.description,
                title: 'Terms & Conditions',
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.code,
                title: 'Open Source Licenses',
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.xl),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    Text(
                      'RapidCare is your trusted healthcare companion, providing easy access to medical services, appointments, and health information.',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondaryGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      '© 2026 RapidCare',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondaryGrey,
                      ),
                    ),
                  ],
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
