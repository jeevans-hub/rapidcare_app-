import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import 'quick_action_card.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.0,
        children: [
          QuickActionCard(
            icon: Icons.calendar_today,
            title: 'Book\nAppointment',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.appointments);
            },
          ),
          QuickActionCard(
            icon: Icons.emergency,
            title: 'Emergency',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.emergencyHome);
            },
          ),
          QuickActionCard(
            icon: Icons.medication,
            title: 'Pharmacy',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.pharmacyHome);
            },
          ),
          QuickActionCard(
            icon: Icons.folder_open,
            title: 'Medical\nRecords',
          ),
          QuickActionCard(
            icon: Icons.people,
            title: 'Doctors',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.doctorList);
            },
          ),
          QuickActionCard(
            icon: Icons.local_shipping,
            title: 'Ambulance',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.ambulanceRequest);
            },
          ),
        ],
      ),
    );
  }
}
