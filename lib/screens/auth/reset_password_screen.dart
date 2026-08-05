import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/section_title.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              const Icon(
                Icons.lock_open,
                size: 80,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(height: AppSpacing.md),
              const SectionTitle(
                title: 'Reset Password',
                subtitle: 'Create a new secure password',
              ),
              const SizedBox(height: AppSpacing.xl),
              const CustomTextField(
                label: 'New Password',
                hint: 'Enter your new password',
                prefixIcon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: AppSpacing.md),
              const CustomTextField(
                label: 'Confirm Password',
                hint: 'Confirm your new password',
                prefixIcon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                text: 'Update Password',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              const Center(
                child: Icon(
                  Icons.check_circle,
                  size: 60,
                  color: AppColors.successGreen,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Password updated successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.successGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
