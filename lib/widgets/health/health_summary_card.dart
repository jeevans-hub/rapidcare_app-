import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthSummaryCard extends StatelessWidget {
  final String overallHealth;
  final String dailyActivity;
  final String waterIntake;
  final String sleep;
  final String exercise;

  const HealthSummaryCard({
    super.key,
    required this.overallHealth,
    required this.dailyActivity,
    required this.waterIntake,
    required this.sleep,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryBlue.withValues(alpha: 0.1),
            AppColors.secondaryTeal.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(
          color: AppColors.primaryBlue.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.health_and_safety,
                color: AppColors.primaryBlue,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Overall Health',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppRadius.small),
                ),
                child: Text(
                  overallHealth,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.successGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _SummaryRow(
            icon: Icons.directions_walk,
            label: 'Daily Activity',
            value: dailyActivity,
          ),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            icon: Icons.water_drop,
            label: 'Water Intake',
            value: waterIntake,
          ),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            icon: Icons.bedtime,
            label: 'Sleep',
            value: sleep,
          ),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            icon: Icons.fitness_center,
            label: 'Exercise',
            value: exercise,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.textSecondaryGrey,
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondaryGrey,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
