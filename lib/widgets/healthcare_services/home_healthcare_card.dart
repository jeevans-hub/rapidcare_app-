import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../primary_button.dart';

class HomeHealthcareCard extends StatelessWidget {
  const HomeHealthcareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.home,
              size: 48,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Home Healthcare',
              style: AppTextStyles.title,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Care services available in a home setting.',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: AppSpacing.md),
            PrimaryButton(
              text: 'Explore Services',
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.homeHealthcare);
              },
            ),
          ],
        ),
      ),
    );
  }
}
