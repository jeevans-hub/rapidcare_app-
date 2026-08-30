import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/reminder_model.dart';
import '../../services/reminder_service.dart';
import '../../widgets/notifications/notification_widgets.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});
  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  List<Reminder> _reminders = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() { super.initState(); _loadReminders(); }

  Future<void> _loadReminders() async {
    setState(() { _loading = true; _error = null; });
    final result = await ReminderService.getReminders();
    if (!mounted) return;
    if (result['success'] == true) {
      final data = result['data'] as Map?;
      final values = data?['reminders'] as List? ?? [];
      setState(() { _reminders = values.whereType<Map>().map((value) => Reminder.fromJson(Map<String, dynamic>.from(value))).toList(); _loading = false; });
    } else {
      setState(() { _error = result['message']?.toString() ?? 'Failed to fetch reminders'; _loading = false; });
    }
  }

  ReminderStatus _status(String status) => status == 'completed' ? ReminderStatus.completed : status == 'cancelled' ? ReminderStatus.paused : ReminderStatus.active;
  IconData _icon(String type) { switch (type) { case 'medicine': return Icons.medication; case 'appointment': return Icons.calendar_today; case 'exercise': return Icons.directions_walk; case 'water': return Icons.water_drop; case 'health_checkup': return Icons.health_and_safety; default: return Icons.notifications; } }
  String _dateTime(Reminder reminder) => [reminder.reminderDate, reminder.reminderTime].where((value) => value != null && value!.isNotEmpty).join(' — ').isEmpty ? 'No date or time set' : [reminder.reminderDate, reminder.reminderTime].where((value) => value != null && value!.isNotEmpty).join(' — ');

  Future<void> _createReminder() async {
    final values = await showDialog<Map<String, String>>(context: context, builder: (_) => const _ReminderDialog());
    if (values == null) return;
    final result = await ReminderService.createReminder(title: values['title']!, description: values['description'], reminderType: values['reminderType']!, reminderDate: values['reminderDate'], reminderTime: values['reminderTime'], repeat: values['repeat']!);
    if (!mounted) return;
    if (result['success'] == true) { _loadReminders(); } else { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message']?.toString() ?? 'Failed to create reminder'))); }
  }

  Future<void> _toggle(Reminder reminder) async {
    final result = await ReminderService.updateReminder(reminder.id, {'isActive': !reminder.isActive});
    if (result['success'] == true) _loadReminders();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Reminders')),
        body: SafeArea(child: _body()),
        floatingActionButton: FloatingActionButton(onPressed: _createReminder, child: const Icon(Icons.add)),
      );

  Widget _body() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_error!), const SizedBox(height: AppSpacing.md), ElevatedButton(onPressed: _loadReminders, child: const Text('Retry'))]));
    return RefreshIndicator(
      onRefresh: _loadReminders,
      child: ListView(padding: const EdgeInsets.all(AppSpacing.lg), children: [
        const NotificationHeader(title: 'Reminders', subtitle: 'Never miss important health activities'),
        const SizedBox(height: AppSpacing.lg),
        if (_reminders.isEmpty) const NotificationEmptyState(title: 'No reminders', message: 'Create a reminder to keep track of your health activities.'),
        if (_reminders.isNotEmpty) ..._reminders.map((reminder) => Padding(padding: const EdgeInsets.only(bottom: AppSpacing.sm), child: ReminderCard(
          icon: _icon(reminder.reminderType), title: reminder.title, description: reminder.description ?? '', dateTime: _dateTime(reminder), status: _status(reminder.status), isEnabled: reminder.isActive,
          onTap: () => Navigator.pushNamed(context, AppRoutes.reminderDetails, arguments: {'reminderId': reminder.id}).then((_) => _loadReminders()), onToggle: reminder.status == 'pending' ? () => _toggle(reminder) : null,
        ))),
      ]),
    );
  }
}

class _ReminderDialog extends StatefulWidget {
  const _ReminderDialog();
  @override
  State<_ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<_ReminderDialog> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _date = TextEditingController();
  final _time = TextEditingController();
  String _type = 'general';
  String _repeat = 'none';

  @override
  void dispose() { _title.dispose(); _description.dispose(); _date.dispose(); _time.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Create Reminder'),
        content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: _title, decoration: const InputDecoration(labelText: 'Title *')),
          TextField(controller: _description, decoration: const InputDecoration(labelText: 'Description')),
          TextField(controller: _date, decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)')),
          TextField(controller: _time, decoration: const InputDecoration(labelText: 'Time (HH:mm)')),
          DropdownButtonFormField<String>(value: _type, decoration: const InputDecoration(labelText: 'Type'), items: const ['general', 'medicine', 'appointment', 'health_checkup', 'exercise', 'water'].map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(), onChanged: (value) => setState(() => _type = value ?? 'general')),
          DropdownButtonFormField<String>(value: _repeat, decoration: const InputDecoration(labelText: 'Repeat'), items: const ['none', 'daily', 'weekly', 'monthly'].map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(), onChanged: (value) => setState(() => _repeat = value ?? 'none')),
        ])),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')), ElevatedButton(onPressed: () { if (_title.text.trim().isEmpty) return; Navigator.pop(context, {'title': _title.text.trim(), 'description': _description.text.trim(), 'reminderDate': _date.text.trim(), 'reminderTime': _time.text.trim(), 'reminderType': _type, 'repeat': _repeat}); }, child: const Text('Save'))],
      );
}
