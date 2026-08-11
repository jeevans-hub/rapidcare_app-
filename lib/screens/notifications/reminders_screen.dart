import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/notifications/notification_widgets.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NotificationHeader(
                  title: 'Reminders',
                  subtitle: 'Never miss important health activities',
                ),
                const SizedBox(height: AppSpacing.lg),
                ReminderList(
                  reminders: [
                    ReminderItem(
                      icon: Icons.calendar_today,
                      title: 'Doctor Appointment',
                      description: 'Dr. Sarah Johnson',
                      dateTime: 'Tomorrow — 10:00 AM',
                      status: ReminderStatus.active,
                      isEnabled: true,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.reminderDetails);
                      },
                      onToggle: () {},
                    ),
                    ReminderItem(
                      icon: Icons.medication,
                      title: 'Take Medicine',
                      description: 'Daily medicine reminder',
                      dateTime: 'Today — 08:00 PM',
                      status: ReminderStatus.active,
                      isEnabled: true,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.reminderDetails);
                      },
                      onToggle: () {},
                    ),
                    ReminderItem(
                      icon: Icons.water_drop,
                      title: 'Drink Water',
                      description: 'Drink 8 glasses of water',
                      dateTime: 'Today — 06:00 PM',
                      status: ReminderStatus.completed,
                      isEnabled: true,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.reminderDetails);
                      },
                      onToggle: () {},
                    ),
                    ReminderItem(
                      icon: Icons.directions_walk,
                      title: 'Exercise',
                      description: '30 minute walk',
                      dateTime: 'Today — 07:00 AM',
                      status: ReminderStatus.completed,
                      isEnabled: true,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.reminderDetails);
                      },
                      onToggle: () {},
                    ),
                    ReminderItem(
                      icon: Icons.bedtime,
                      title: 'Sleep',
                      description: 'Prepare for bedtime',
                      dateTime: 'Today — 10:00 PM',
                      status: ReminderStatus.active,
                      isEnabled: true,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.reminderDetails);
                      },
                      onToggle: () {},
                    ),
                    ReminderItem(
                      icon: Icons.medical_services,
                      title: 'Prescription Refill',
                      description: 'Refill monthly prescription',
                      dateTime: 'Aug 15 — 09:00 AM',
                      status: ReminderStatus.paused,
                      isEnabled: false,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.reminderDetails);
                      },
                      onToggle: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
