import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class DoctorStatisticsCard extends StatelessWidget {
  final int patientsServed;
  final int yearsExperience;
  final double rating;
  final int reviewsCount;

  const DoctorStatisticsCard({
    super.key,
    required this.patientsServed,
    required this.yearsExperience,
    required this.rating,
    required this.reviewsCount,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            icon: Icons.people,
            label: 'Patients',
            value: '${(patientsServed / 1000).toStringAsFixed(1)}K+',
            color: AppColors.primaryBlue,
          ),
          _StatItem(
            icon: Icons.work,
            label: 'Experience',
            value: '$yearsExperience+ Years',
            color: AppColors.secondaryTeal,
          ),
          _StatItem(
            icon: Icons.star,
            label: 'Rating',
            value: rating.toStringAsFixed(1),
            color: AppColors.warningOrange,
          ),
          _StatItem(
            icon: Icons.rate_review,
            label: 'Reviews',
            value: '$reviewsCount+',
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          value,
          style: AppTextStyles.title.copyWith(
            fontSize: 18,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondaryGrey,
          ),
        ),
      ],
    );
  }
}
