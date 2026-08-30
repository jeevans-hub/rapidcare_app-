import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/reminder_model.dart';
import '../../services/reminder_service.dart';

class ReminderDetailsScreen extends StatefulWidget {
  const ReminderDetailsScreen({super.key});

  @override
  State<ReminderDetailsScreen> createState() => _ReminderDetailsScreenState();
}

class _ReminderDetailsScreenState extends State<ReminderDetailsScreen> {
  Reminder? _reminder;
  bool _loading = true;
  String? _error;
  String? _id;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_id != null) return;
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map) _id = args['reminderId']?.toString();
    if (_id != null) _load();
  }

  Future<void> _load() async {
    final result = await ReminderService.getReminder(_id!);
    if (!mounted) return;
    if (result['success'] == true) {
      final data = result['data'];
      final reminderData = data is Map ? data['reminder'] : null;
      if (reminderData is Map) {
        setState(() {
          _reminder = Reminder.fromJson(Map<String, dynamic>.from(reminderData));
          _loading = false;
        });
        return;
      }
    }
    setState(() {
      _error = result['message']?.toString() ?? 'Failed to fetch reminder';
      _loading = false;
    });
  }

  Future<void> _action(Future<Map<String, dynamic>> request) async {
    final result = await request;
    if (!mounted) return;
    if (result['success'] == true) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message']?.toString() ?? 'Request failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_error != null || _reminder == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_error ?? 'Reminder not found'),
              ElevatedButton(onPressed: _load, child: const Text('Retry')),
            ],
          ),
        ),
      );
    }

    final reminder = _reminder!;
    return Scaffold(
      appBar: AppBar(title: const Text('Reminder Details')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reminder.title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              Text(reminder.description ?? 'No description'),
              const SizedBox(height: AppSpacing.lg),
              Text('Type: ${reminder.reminderType}'),
              Text('Date: ${reminder.reminderDate ?? 'Not set'}'),
              Text('Time: ${reminder.reminderTime ?? 'Not set'}'),
              Text('Repeat: ${reminder.repeat}'),
              Text('Status: ${reminder.status}'),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: reminder.status == 'pending'
                          ? () => _action(ReminderService.completeReminder(reminder.id))
                          : null,
                      child: const Text('Complete'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _action(ReminderService.deleteReminder(reminder.id)),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
