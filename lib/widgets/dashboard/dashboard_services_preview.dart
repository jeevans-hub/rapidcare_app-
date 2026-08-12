import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class DashboardServicesPreview extends StatelessWidget {
  const DashboardServicesPreview({super.key});

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
                  Icons.health_and_safety,
                  color: AppColors.primaryBlue,
                  size: 24,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Healthcare Services',
                  style: AppTextStyles.title,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _ServiceChip(
                  icon: Icons.medical_services,
                  label: 'Consultation',
                ),
                _ServiceChip(
                  icon: Icons.local_pharmacy,
                  label: 'Pharmacy',
                ),
                _ServiceChip(
                  icon: Icons.emergency,
                  label: 'Emergency',
                ),
                _ServiceChip(
                  icon: Icons.security,
                  label: 'Insurance',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.healthcareServices);
              },
              child: const Text('View All Services'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ServiceChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundLightGrey,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.primaryBlue,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}
