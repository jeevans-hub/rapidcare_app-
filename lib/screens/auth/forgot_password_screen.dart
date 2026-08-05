import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/section_title.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              const Icon(
                Icons.lock_reset,
                size: 80,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(height: AppSpacing.md),
              const SectionTitle(
                title: 'Forgot Password',
                subtitle: 'Enter your email to receive a reset link',
              ),
              const SizedBox(height: AppSpacing.xl),
              const CustomTextField(
                label: 'Email Address',
                hint: 'Enter your email',
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                text: 'Send Reset Link',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.otpVerification);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
