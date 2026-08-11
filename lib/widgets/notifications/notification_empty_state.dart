import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class NotificationEmptyState extends StatelessWidget {
  final String? title;
  final String? message;

  const NotificationEmptyState({
    super.key,
    this.title,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 80,
              color: AppColors.textSecondaryGrey,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title ?? 'No notifications',
              style: AppTextStyles.title.copyWith(
                color: AppColors.textSecondaryGrey,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message ?? 'You\'re all caught up!',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondaryGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
