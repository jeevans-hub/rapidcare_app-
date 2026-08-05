import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import 'health_stat_card.dart';

class HealthStatisticsSection extends StatelessWidget {
  const HealthStatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Health Statistics'),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                HealthStatCard(
                  icon: Icons.favorite,
                  label: 'Heart Rate',
                  value: '72 BPM',
                  iconColor: AppColors.errorRed,
                ),
                SizedBox(width: AppSpacing.md),
                HealthStatCard(
                  icon: Icons.bloodtype,
                  label: 'Blood Pressure',
                  value: '120/80',
                  iconColor: AppColors.primaryBlue,
                ),
                SizedBox(width: AppSpacing.md),
                HealthStatCard(
                  icon: Icons.water_drop,
                  label: 'Blood Sugar',
                  value: '95 mg/dL',
                  iconColor: AppColors.secondaryTeal,
                ),
                SizedBox(width: AppSpacing.md),
                HealthStatCard(
                  icon: Icons.monitor_weight,
                  label: 'Weight',
                  value: '68 kg',
                  iconColor: AppColors.warningOrange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
