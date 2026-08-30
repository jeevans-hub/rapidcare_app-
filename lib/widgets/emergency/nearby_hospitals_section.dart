import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import 'nearby_hospital_card.dart';
import 'emergency_action_dialogs.dart';

class NearbyHospitalsSection extends StatelessWidget {
  const NearbyHospitalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Nearby Hospitals',
          subtitle: 'Hospitals near your location',
        ),
        const SizedBox(height: AppSpacing.md),
        NearbyHospitalCard(
          name: 'City General Hospital',
          distance: '2.5 km',
          estimatedArrival: '8 min',
          onNavigate: () => EmergencyActionDialogs.showNearestHospitalInfo(context),
        ),
        const SizedBox(height: AppSpacing.sm),
        NearbyHospitalCard(
          name: 'St. Mary Medical Center',
          distance: '3.8 km',
          estimatedArrival: '12 min',
          onNavigate: () => EmergencyActionDialogs.showNearestHospitalInfo(context),
        ),
        const SizedBox(height: AppSpacing.sm),
        NearbyHospitalCard(
          name: 'Riverside Hospital',
          distance: '5.2 km',
          estimatedArrival: '15 min',
          onNavigate: () => EmergencyActionDialogs.showNearestHospitalInfo(context),
        ),
      ],
    );
  }
}
