import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';

class MedicalRecordEmptyState extends StatelessWidget {
  final VoidCallback? onGoBack;

  const MedicalRecordEmptyState({
    super.key,
    this.onGoBack,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.backgroundLightGrey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.folder_off,
                size: 60,
                color: AppColors.textSecondaryGrey,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'No medical records found',
              style: AppTextStyles.title,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Your medical records will appear here.',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondaryGrey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            if (onGoBack != null)
              PrimaryButton(
                text: 'Go Back',
                onPressed: onGoBack,
              ),
          ],
        ),
      ),
    );
  }
}
