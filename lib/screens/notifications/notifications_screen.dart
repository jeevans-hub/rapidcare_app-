import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/notification_model.dart';
import '../../services/notification_service.dart';
import '../../widgets/notifications/notification_widgets.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String selectedFilter = 'All';
  List<AppNotification> _notifications = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() { super.initState(); _loadNotifications(); }

  String? get _typeFilter {
    const types = {'Appointments': 'appointment', 'Medicines': 'reminder', 'Pharmacy': 'pharmacy_order', 'General': 'general'};
    return types[selectedFilter];
  }

  Future<void> _loadNotifications() async {
    setState(() { _loading = true; _error = null; });
    final result = await NotificationService.getNotifications(type: _typeFilter);
    if (!mounted) return;
    if (result['success'] == true) {
      final data = result['data'] as Map?;
      final values = data?['notifications'] as List? ?? [];
      setState(() { _notifications = values.whereType<Map>().map((value) => AppNotification.fromJson(Map<String, dynamic>.from(value))).toList(); _loading = false; });
    } else {
      setState(() { _error = result['message']?.toString() ?? 'Failed to fetch notifications'; _loading = false; });
    }
  }

  NotificationType _iconType(String type) {
    switch (type) {
      case 'appointment': return NotificationType.appointment;
      case 'reminder': return NotificationType.medicine;
      case 'medical_record': return NotificationType.health;
      case 'pharmacy_order': return NotificationType.pharmacy;
      default: return NotificationType.general;
    }
  }

  String _dateLabel(DateTime date) {
    final local = date.toLocal();
    return '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _markRead(AppNotification notification) async {
    if (!notification.isRead) { await NotificationService.markAsRead(notification.id); await _loadNotifications(); }
  }

  Future<void> _markAllRead() async { await NotificationService.markAllAsRead(); await _loadNotifications(); }
  Future<void> _delete(AppNotification notification) async { await NotificationService.deleteNotification(notification.id); await _loadNotifications(); }

  @override
  Widget build(BuildContext context) {
    final hasUnread = _notifications.any((item) => !item.isRead);
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications'), actions: [
        IconButton(icon: const Icon(Icons.done_all), tooltip: 'Mark all as read', onPressed: hasUnread ? _markAllRead : null),
        IconButton(icon: const Icon(Icons.alarm), onPressed: () => Navigator.pushNamed(context, AppRoutes.reminders)),
        IconButton(icon: const Icon(Icons.settings), onPressed: () => Navigator.pushNamed(context, AppRoutes.notificationPreferences)),
      ]),
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_error!), const SizedBox(height: AppSpacing.md), ElevatedButton(onPressed: _loadNotifications, child: const Text('Retry'))]));
    return RefreshIndicator(
      onRefresh: _loadNotifications,
      child: ListView(padding: const EdgeInsets.all(AppSpacing.lg), children: [
        const NotificationHeader(title: 'Notifications', subtitle: 'Stay updated with your health journey'),
        const SizedBox(height: AppSpacing.lg),
        NotificationFilters(filters: const ['All', 'Appointments', 'Medicines', 'Health', 'Pharmacy', 'Emergency', 'General'], selectedFilter: selectedFilter, onFilterSelected: (filter) { setState(() => selectedFilter = filter); _loadNotifications(); }),
        const SizedBox(height: AppSpacing.lg),
        if (_notifications.isEmpty) const NotificationEmptyState(title: 'No notifications', message: 'You are all caught up.'),
        if (_notifications.isNotEmpty) NotificationGroup(title: 'Recent', notifications: _notifications.map((notification) => NotificationItem(
          type: _iconType(notification.type), title: notification.title, description: notification.message, priority: notification.priority, time: _dateLabel(notification.createdAt), isRead: notification.isRead,
          onTap: () { _markRead(notification); Navigator.pushNamed(context, AppRoutes.notificationDetails, arguments: {'notification': notification}); },
          onDelete: () => _delete(notification),
        )).toList()),
      ]),
    );
  }
}
