import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class InsuranceDocumentCard extends StatelessWidget {
  final String documentName;
  final String documentType;
  final String date;
  final VoidCallback? onTap;

  const InsuranceDocumentCard({
    super.key,
    required this.documentName,
    required this.documentType,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.large),
      splashColor: AppColors.primaryBlueLight.withValues(alpha: 0.3),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Icon(
                Icons.insert_drive_file,
                size: 40,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      documentName,
                      style: AppTextStyles.title,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      documentType,
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      date,
                      style: AppTextStyles.small,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textSecondaryGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
