import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import '../../widgets/info_card.dart';

class NearbyHospitalSection extends StatelessWidget {
  const NearbyHospitalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Nearby Hospitals'),
          const SizedBox(height: AppSpacing.md),
          const InfoCard(
            icon: Icons.local_hospital,
            title: 'City General Hospital',
            subtitle: '1.2 km • Open Now',
          ),
          const SizedBox(height: AppSpacing.sm),
          const InfoCard(
            icon: Icons.local_hospital,
            title: 'St. Mary\'s Medical Center',
            subtitle: '2.5 km • Open Now',
          ),
          const SizedBox(height: AppSpacing.sm),
          const InfoCard(
            icon: Icons.local_hospital,
            title: 'Riverside Clinic',
            subtitle: '3.8 km • Closes at 8 PM',
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
