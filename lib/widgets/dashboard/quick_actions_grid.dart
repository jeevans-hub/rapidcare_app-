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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final textScale = MediaQuery.textScalerOf(context).scale(12) / 12;
          final crossAxisCount =
              ((constraints.maxWidth + AppSpacing.md) /
                      (100 * textScale + AppSpacing.md))
                  .floor()
                  .clamp(1, 3);
          final tileWidth =
              (constraints.maxWidth - AppSpacing.md * (crossAxisCount - 1)) /
              crossAxisCount;
          final minHeight = 112 * textScale;
          final tileHeight = tileWidth > minHeight ? tileWidth : minHeight;

          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: tileWidth / tileHeight,
            children: [
              QuickActionCard(
                icon: Icons.calendar_today,
                title: 'Book\nAppointment',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.appointments);
                },
              ),
              QuickActionCard(
                icon: Icons.folder_open,
                title: 'Medical\nRecords',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.medicalRecords);
                },
              ),
              QuickActionCard(
                icon: Icons.monitor_heart,
                title: 'Health\nMonitoring',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.healthMonitoring);
                },
              ),
              QuickActionCard(
                icon: Icons.assessment,
                title: 'Health\nReports',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.healthReports);
                },
              ),
              QuickActionCard(
                icon: Icons.favorite,
                title: 'Health &\nWellness',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.healthHome);
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
                icon: Icons.people,
                title: 'Doctors',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.doctorList);
                },
              ),
              QuickActionCard(
                icon: Icons.health_and_safety,
                title: 'Health\nEducation',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.healthEducation);
                },
              ),
              QuickActionCard(
                icon: Icons.emergency,
                title: 'Emergency',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.emergencyHome);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
