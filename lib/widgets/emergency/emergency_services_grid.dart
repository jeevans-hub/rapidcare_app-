import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'emergency_service_card.dart';
import 'emergency_action_dialogs.dart';

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
          children: [
            EmergencyServiceCard(
              icon: Icons.local_hospital,
              title: 'Call Ambulance',
              onTap: () => EmergencyActionDialogs.showAmbulanceInfo(context),
            ),
            EmergencyServiceCard(
              icon: Icons.location_on,
              title: 'Nearest Hospital',
              onTap: () => EmergencyActionDialogs.showNearestHospitalInfo(context),
            ),
            EmergencyServiceCard(
              icon: Icons.local_police,
              title: 'Police',
              onTap: () => EmergencyActionDialogs.showPoliceInfo(context),
            ),
            EmergencyServiceCard(
              icon: Icons.local_fire_department,
              title: 'Fire Department',
              onTap: () => EmergencyActionDialogs.showFireInfo(context),
            ),
            EmergencyServiceCard(
              icon: Icons.science,
              title: 'Poison Control',
              onTap: () => EmergencyActionDialogs.showPoisonInfo(context),
            ),
            EmergencyServiceCard(
              icon: Icons.bloodtype,
              title: 'Blood Bank',
              onTap: () => EmergencyActionDialogs.showBloodBankInfo(context),
            ),
          ],
        );
      },
    );
  }
}
