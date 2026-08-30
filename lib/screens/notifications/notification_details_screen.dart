import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/notification_model.dart';
import '../../services/notification_service.dart';
import '../../widgets/notifications/notification_widgets.dart';

class NotificationDetailsScreen extends StatefulWidget {
  const NotificationDetailsScreen({super.key});
  @override
  State<NotificationDetailsScreen> createState() => _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  AppNotification? _notification;
  bool _busy = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (_notification == null && args is Map && args['notification'] is AppNotification) {
      _notification = args['notification'] as AppNotification;
      if (!_notification!.isRead) NotificationService.markAsRead(_notification!.id);
    }
  }

  NotificationType _type(String type) { switch (type) { case 'appointment': return NotificationType.appointment; case 'reminder': return NotificationType.medicine; case 'medical_record': return NotificationType.health; case 'pharmacy_order': return NotificationType.pharmacy; default: return NotificationType.general; } }

  Future<void> _delete() async {
    if (_notification == null || _busy) return;
    setState(() => _busy = true);
    final result = await NotificationService.deleteNotification(_notification!.id);
    if (!mounted) return;
    if (result['success'] == true) Navigator.pop(context, true); else setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final notification = _notification;
    if (notification == null) return const Scaffold(body: Center(child: Text('Notification not found')));
    return Scaffold(appBar: AppBar(title: const Text('Notification Details')), body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(AppSpacing.lg), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      NotificationTypeIcon(type: _type(notification.type)), const SizedBox(height: AppSpacing.lg), Text(notification.title, style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: AppSpacing.sm), Text(notification.message), const SizedBox(height: AppSpacing.lg), Text('Type: ${notification.type}'), const SizedBox(height: AppSpacing.sm), Text('Priority: ${notification.priority}'), const SizedBox(height: AppSpacing.sm), Text('Received: ${notification.createdAt.toLocal()}'), const SizedBox(height: AppSpacing.xl),
      Row(children: [Expanded(child: OutlinedButton(onPressed: _busy ? null : () async { await NotificationService.markAsRead(notification.id); if (mounted) Navigator.pop(context, true); }, child: const Text('Mark as Read'))), const SizedBox(width: AppSpacing.md), Expanded(child: OutlinedButton(onPressed: _busy ? null : _delete, child: const Text('Delete')))]),
    ]))));
  }
}
