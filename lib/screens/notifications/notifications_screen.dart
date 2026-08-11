import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/notifications/notification_widgets.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NotificationHeader(
                  title: 'Notifications',
                  subtitle: 'Stay updated with your health journey',
                ),
                const SizedBox(height: AppSpacing.lg),
                NotificationFilters(
                  filters: const [
                    'All',
                    'Appointments',
                    'Medicines',
                    'Health',
                    'Pharmacy',
                    'Emergency',
                    'General',
                  ],
                  selectedFilter: selectedFilter,
                  onFilterSelected: (filter) {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                NotificationGroup(
                  title: 'Today',
                  notifications: [
                    NotificationItem(
                      type: NotificationType.appointment,
                      title: 'Appointment Reminder',
                      description: 'Your appointment with Dr. Sarah Johnson is tomorrow at 10:00 AM.',
                      time: '2 hours ago',
                      isRead: false,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.notificationDetails);
                      },
                    ),
                    NotificationItem(
                      type: NotificationType.medicine,
                      title: 'Medicine Reminder',
                      description: 'Time to take your scheduled medicine.',
                      time: '4 hours ago',
                      isRead: false,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.notificationDetails);
                      },
                    ),
                    NotificationItem(
                      type: NotificationType.health,
                      title: 'Health Reminder',
                      description: 'Remember to stay hydrated throughout the day.',
                      time: '6 hours ago',
                      isRead: true,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.notificationDetails);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                NotificationGroup(
                  title: 'Yesterday',
                  notifications: [
                    NotificationItem(
                      type: NotificationType.pharmacy,
                      title: 'Pharmacy Update',
                      description: 'Your pharmacy order has been confirmed.',
                      time: 'Yesterday',
                      isRead: true,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.notificationDetails);
                      },
                    ),
                    NotificationItem(
                      type: NotificationType.emergency,
                      title: 'Emergency Information',
                      description: 'Emergency contact information has been updated.',
                      time: 'Yesterday',
                      isRead: true,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.notificationDetails);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                NotificationGroup(
                  title: 'Earlier',
                  notifications: [
                    NotificationItem(
                      type: NotificationType.general,
                      title: 'Profile Updated',
                      description: 'Your RapidCare profile was successfully updated.',
                      time: '3 days ago',
                      isRead: true,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.notificationDetails);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
