import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'emergency_service_card.dart';

class EmergencyServicesGrid extends StatelessWidget {
  const EmergencyServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        
        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          childAspectRatio: 1.0,
          children: const [
            EmergencyServiceCard(
              icon: Icons.local_hospital,
              title: 'Call Ambulance',
            ),
            EmergencyServiceCard(
              icon: Icons.location_on,
              title: 'Nearest Hospital',
            ),
            EmergencyServiceCard(
              icon: Icons.local_police,
              title: 'Police',
            ),
            EmergencyServiceCard(
              icon: Icons.local_fire_department,
              title: 'Fire Department',
            ),
            EmergencyServiceCard(
              icon: Icons.science,
              title: 'Poison Control',
            ),
            EmergencyServiceCard(
              icon: Icons.bloodtype,
              title: 'Blood Bank',
            ),
          ],
        );
      },
    );
  }
}
