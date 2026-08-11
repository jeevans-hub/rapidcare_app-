import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() => _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState extends State<NotificationPreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Preferences'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.md),
              _PreferenceSection(
                title: 'Appointment Notifications',
                items: [
                  _PreferenceItem(
                    icon: Icons.calendar_today,
                    title: 'Appointment Reminders',
                    subtitle: 'Get reminded about upcoming appointments',
                    value: true,
                  ),
                  _PreferenceItem(
                    icon: Icons.update,
                    title: 'Appointment Updates',
                    subtitle: 'Receive updates on appointment changes',
                    value: true,
                  ),
                  _PreferenceItem(
                    icon: Icons.person,
                    title: 'Doctor Appointment Changes',
                    subtitle: 'Notifications when doctors change schedules',
                    value: false,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _PreferenceSection(
                title: 'Medicine Notifications',
                items: [
                  _PreferenceItem(
                    icon: Icons.medication,
                    title: 'Medicine Reminders',
                    subtitle: 'Daily medicine intake reminders',
                    value: true,
                  ),
                  _PreferenceItem(
                    icon: Icons.description,
                    title: 'Prescription Updates',
                    subtitle: 'Updates on prescription changes',
                    value: true,
                  ),
                  _PreferenceItem(
                    icon: Icons.local_pharmacy,
                    title: 'Pharmacy Order Updates',
                    subtitle: 'Track your pharmacy orders',
                    value: true,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _PreferenceSection(
                title: 'Health & Wellness',
                items: [
                  _PreferenceItem(
                    icon: Icons.flag,
                    title: 'Health Goals',
                    subtitle: 'Progress updates on health goals',
                    value: true,
                  ),
                  _PreferenceItem(
                    icon: Icons.water_drop,
                    title: 'Water Reminders',
                    subtitle: 'Stay hydrated with water reminders',
                    value: true,
                  ),
                  _PreferenceItem(
                    icon: Icons.bedtime,
                    title: 'Sleep Reminders',
                    subtitle: 'Bedtime reminders for better sleep',
                    value: true,
                  ),
                  _PreferenceItem(
                    icon: Icons.fitness_center,
                    title: 'Exercise Reminders',
                    subtitle: 'Daily exercise activity reminders',
                    value: true,
                  ),
                  _PreferenceItem(
                    icon: Icons.lightbulb,
                    title: 'Wellness Tips',
                    subtitle: 'Daily health and wellness tips',
                    value: false,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _PreferenceSection(
                title: 'Emergency',
                items: [
                  _PreferenceItem(
                    icon: Icons.emergency,
                    title: 'Emergency Alerts',
                    subtitle: 'Critical emergency notifications',
                    value: true,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _PreferenceSection(
                title: 'Marketing',
                items: [
                  _PreferenceItem(
                    icon: Icons.campaign,
                    title: 'Promotional Notifications',
                    subtitle: 'Offers and promotional content',
                    value: false,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreferenceSection extends StatelessWidget {
  final String title;
  final List<_PreferenceItem> items;

  const _PreferenceSection({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Text(
            title,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondaryGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          color: Colors.white,
          child: Column(
            children: items.map((item) {
              return SwitchListTile(
                secondary: Icon(
                  item.icon,
                  color: AppColors.primaryBlue,
                ),
                title: Text(item.title),
                subtitle: Text(item.subtitle),
                value: item.value,
                onChanged: (value) {},
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _PreferenceItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;

  _PreferenceItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
  });
}
