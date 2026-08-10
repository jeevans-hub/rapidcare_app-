import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/settings/settings_widgets.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _appointmentReminders = true;
  bool _medicineReminders = true;
  bool _emergencyAlerts = true;
  bool _healthTips = false;
  bool _promotionalNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.md),
              SettingsSwitchTile(
                icon: Icons.calendar_today,
                title: 'Appointment Reminders',
                subtitle: 'Get notified about upcoming appointments',
                value: _appointmentReminders,
                onChanged: (value) {
                  setState(() {
                    _appointmentReminders = value;
                  });
                },
              ),
              SettingsSwitchTile(
                icon: Icons.medication,
                title: 'Medicine Reminders',
                subtitle: 'Get notified about medicine schedules',
                value: _medicineReminders,
                onChanged: (value) {
                  setState(() {
                    _medicineReminders = value;
                  });
                },
              ),
              SettingsSwitchTile(
                icon: Icons.emergency,
                title: 'Emergency Alerts',
                subtitle: 'Get notified about emergency situations',
                value: _emergencyAlerts,
                onChanged: (value) {
                  setState(() {
                    _emergencyAlerts = value;
                  });
                },
              ),
              SettingsSwitchTile(
                icon: Icons.health_and_safety,
                title: 'Health Tips',
                subtitle: 'Receive daily health tips',
                value: _healthTips,
                onChanged: (value) {
                  setState(() {
                    _healthTips = value;
                  });
                },
              ),
              SettingsSwitchTile(
                icon: Icons.campaign,
                title: 'Promotional Notifications',
                subtitle: 'Receive offers and promotions',
                value: _promotionalNotifications,
                onChanged: (value) {
                  setState(() {
                    _promotionalNotifications = value;
                  });
                },
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
