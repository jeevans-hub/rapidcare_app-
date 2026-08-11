import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class DoctorExperienceCard extends StatelessWidget {
  final List<ExperienceItem> experiences;

  const DoctorExperienceCard({
    super.key,
    required this.experiences,
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
                Icons.work,
                color: AppColors.primaryBlue,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Experience',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...experiences.map((experience) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _ExperienceItem(
                hospital: experience.hospital,
                role: experience.role,
                duration: experience.duration,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final String hospital;
  final String role;
  final String duration;

  const _ExperienceItem({
    required this.hospital,
    required this.role,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          role,
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          hospital,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondaryGrey,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          duration,
          style: AppTextStyles.small.copyWith(
            color: AppColors.primaryBlue,
          ),
        ),
      ],
    );
  }
}

class ExperienceItem {
  final String hospital;
  final String role;
  final String duration;

  ExperienceItem({
    required this.hospital,
    required this.role,
    required this.duration,
  });
}
