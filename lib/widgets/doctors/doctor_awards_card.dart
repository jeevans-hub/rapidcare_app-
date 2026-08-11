import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class DoctorAwardsCard extends StatelessWidget {
  final List<AwardItem> awards;

  const DoctorAwardsCard({
    super.key,
    required this.awards,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.backgroundLightGreyDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events,
                color: AppColors.warningOrange,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Awards & Achievements',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...awards.map((award) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _AwardItem(
                title: award.title,
                year: award.year,
                description: award.description,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _AwardItem extends StatelessWidget {
  final String title;
  final String year;
  final String description;

  const _AwardItem({
    required this.title,
    required this.year,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.star,
          color: AppColors.warningOrange,
          size: 16,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                year,
                style: AppTextStyles.small.copyWith(
                  color: AppColors.textSecondaryGrey,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondaryGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AwardItem {
  final String title;
  final String year;
  final String description;

  AwardItem({
    required this.title,
    required this.year,
    required this.description,
  });
}
