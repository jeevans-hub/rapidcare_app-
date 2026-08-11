import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class FirstAidCard extends StatelessWidget {
  final String topic;
  final String description;
  final bool isEmergency;
  final VoidCallback? onTap;

  const FirstAidCard({
    super.key,
    required this.topic,
    required this.description,
    this.isEmergency = false,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    isEmergency ? Icons.warning : Icons.healing,
                    size: 32,
                    color: isEmergency ? AppColors.errorRed : AppColors.primaryBlue,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      topic,
                      style: AppTextStyles.title,
                    ),
                  ),
                  if (isEmergency)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.errorRed.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(AppRadius.small),
                      ),
                      child: Text(
                        'Emergency',
                        style: AppTextStyles.small.copyWith(
                          color: AppColors.errorRed,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                description,
                style: AppTextStyles.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),
              if (isEmergency)
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: AppColors.warningOrange,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Seek professional emergency medical assistance',
                        style: AppTextStyles.small,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: onTap,
                child: const Text('View Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
