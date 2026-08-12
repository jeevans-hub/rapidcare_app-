import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class DashboardHealthOverview extends StatelessWidget {
  const DashboardHealthOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.monitor_heart,
                  color: AppColors.primaryBlue,
                  size: 24,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Health Overview',
                  style: AppTextStyles.title,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warningOrange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    'Demo Data',
                    style: AppTextStyles.small.copyWith(
                      color: AppColors.warningOrange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.2,
              children: const [
                _HealthMetricCard(
                  icon: Icons.directions_walk,
                  label: 'Steps',
                  value: '6,420',
                ),
                _HealthMetricCard(
                  icon: Icons.bedtime,
                  label: 'Sleep',
                  value: '7h 20m',
                ),
                _HealthMetricCard(
                  icon: Icons.water_drop,
                  label: 'Water',
                  value: '5 / 8',
                ),
                _HealthMetricCard(
                  icon: Icons.favorite,
                  label: 'Heart Rate',
                  value: '72 BPM',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HealthMetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _HealthMetricCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.backgroundLightGrey,
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.primaryBlue,
            size: 28,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTextStyles.subtitle,
          ),
        ],
      ),
    );
  }
}
