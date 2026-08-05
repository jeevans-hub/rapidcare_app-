import 'package:flutter/material.dart';
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
        children: const [
          QuickActionCard(
            icon: Icons.calendar_today,
            title: 'Book\nAppointment',
          ),
          QuickActionCard(
            icon: Icons.emergency,
            title: 'Emergency',
          ),
          QuickActionCard(
            icon: Icons.medication,
            title: 'Pharmacy',
          ),
          QuickActionCard(
            icon: Icons.folder_open,
            title: 'Medical\nRecords',
          ),
          QuickActionCard(
            icon: Icons.people,
            title: 'Doctors',
          ),
          QuickActionCard(
            icon: Icons.local_shipping,
            title: 'Ambulance',
          ),
        ],
      ),
    );
  }
}
