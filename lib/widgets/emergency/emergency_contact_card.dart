import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class EmergencyContactCard extends StatelessWidget {
  final String name;
  final String relationship;
  final String phoneNumber;
  final VoidCallback? onCall;
  final VoidCallback? onMessage;

  const EmergencyContactCard({
    super.key,
    required this.name,
    required this.relationship,
    required this.phoneNumber,
    this.onCall,
    this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primaryBlueLight,
              child: Text(
                name[0].toUpperCase(),
                style: AppTextStyles.title.copyWith(
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.title,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    relationship,
                    style: AppTextStyles.caption,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    phoneNumber,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              icon: const Icon(Icons.call),
              color: AppColors.successGreen,
              onPressed: onCall,
            ),
            IconButton(
              icon: const Icon(Icons.message),
              color: AppColors.primaryBlue,
              onPressed: onMessage,
            ),
          ],
        ),
      ),
    );
  }
}
