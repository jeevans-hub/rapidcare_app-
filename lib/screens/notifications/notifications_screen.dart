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
            icon: const Icon(Icons.alarm),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.reminders);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.notificationPreferences);
            },
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
                        Navigator.pushNamed(
                          context,
                          AppRoutes.notificationDetails,
                          arguments: {
                            'title': 'Appointment Reminder',
                            'description': 'Your appointment with Dr. Sarah Johnson is tomorrow at 10:00 AM.',
                            'category': 'Appointment',
                            'date': 'Aug 12, 2026',
                            'time': '10:00 AM',
                            'type': 'appointment',
                          },
                        );
                      },
                    ),
                    NotificationItem(
                      type: NotificationType.medicine,
                      title: 'Medicine Reminder',
                      description: 'Time to take your scheduled medicine.',
                      time: '4 hours ago',
                      isRead: false,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.notificationDetails,
                          arguments: {
                            'title': 'Medicine Reminder',
                            'description': 'Time to take your scheduled medicine.',
                            'category': 'Medicine',
                            'date': 'Aug 12, 2026',
                            'time': '08:00 AM',
                            'type': 'medicine',
                          },
                        );
                      },
                    ),
                    NotificationItem(
                      type: NotificationType.health,
                      title: 'Health Reminder',
                      description: 'Remember to stay hydrated throughout the day.',
                      time: '6 hours ago',
                      isRead: true,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.notificationDetails,
                          arguments: {
                            'title': 'Health Reminder',
                            'description': 'Remember to stay hydrated throughout the day.',
                            'category': 'Health',
                            'date': 'Aug 12, 2026',
                            'time': '02:00 PM',
                            'type': 'health',
                          },
                        );
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
                        Navigator.pushNamed(
                          context,
                          AppRoutes.notificationDetails,
                          arguments: {
                            'title': 'Pharmacy Update',
                            'description': 'Your pharmacy order has been confirmed.',
                            'category': 'Pharmacy',
                            'date': 'Aug 11, 2026',
                            'time': '03:30 PM',
                            'type': 'pharmacy',
                          },
                        );
                      },
                    ),
                    NotificationItem(
                      type: NotificationType.emergency,
                      title: 'Emergency Information',
                      description: 'Emergency contact information has been updated.',
                      time: 'Yesterday',
                      isRead: true,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.notificationDetails,
                          arguments: {
                            'title': 'Emergency Information',
                            'description': 'Emergency contact information has been updated.',
                            'category': 'Emergency',
                            'date': 'Aug 11, 2026',
                            'time': '11:00 AM',
                            'type': 'emergency',
                          },
                        );
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
                        Navigator.pushNamed(
                          context,
                          AppRoutes.notificationDetails,
                          arguments: {
                            'title': 'Profile Updated',
                            'description': 'Your RapidCare profile was successfully updated.',
                            'category': 'General',
                            'date': 'Aug 9, 2026',
                            'time': '05:45 PM',
                            'type': 'general',
                          },
                        );
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
