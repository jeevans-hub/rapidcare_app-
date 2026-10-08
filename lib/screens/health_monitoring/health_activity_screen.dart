import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/activity_log_model.dart';
import '../../services/activity_log_service.dart';

class HealthActivityScreen extends StatefulWidget {
  const HealthActivityScreen({super.key});
  @override
  State<HealthActivityScreen> createState() => _HealthActivityScreenState();
}

class _HealthActivityScreenState extends State<HealthActivityScreen> {
  List<ActivityLog> _activities = [];
  bool _loading = true;
  String? _error;
  Map<String, dynamic> _summary = {};
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final result = await ActivityLogService.getActivities();
    if (!mounted) return;
    if (result['success'] == true) {
      final data = result['data'] as Map?;
      final list = data?['activities'] as List? ?? [];
      setState(() {
        _activities = list
            .whereType<Map>()
            .map(
              (item) => ActivityLog.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
        _summary = data?['summary'] is Map
            ? Map<String, dynamic>.from(data!['summary'] as Map)
            : {};
        _loading = false;
      });
    } else {
      setState(() {
        _error = result['message']?.toString() ?? 'Failed to fetch activities';
        _loading = false;
      });
    }
  }

  Future<void> _add() async {
    final values = await showDialog<Map<String, String>>(
      context: context,
      builder: (_) => const _ActivityDialog(),
    );
    if (values == null) return;
    final result = await ActivityLogService.createActivity(
      activityType: values['type']!,
      durationMinutes: int.parse(values['duration']!),
      notes: values['notes'],
    );
    if (!mounted) return;
    if (result['success'] == true) {
      _load();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result['message']?.toString() ?? 'Failed to create activity',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Activity')),
    floatingActionButton: FloatingActionButton(
      onPressed: _add,
      child: const Icon(Icons.add),
    ),
    body: SafeArea(child: _body()),
  );
  Widget _body() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!),
            ElevatedButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          const Text(
            'These values are for personal tracking only. Consult a qualified medical professional for medical interpretation.',
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Total duration: ${_summary['durationMinutes'] ?? 0} minutes'),
          const SizedBox(height: AppSpacing.md),
          if (_activities.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.xl),
                child: Text('No activities recorded yet.'),
              ),
            ),
          ..._activities.map(
            (activity) => Card(
              child: ListTile(
                title: Text(activity.activityType),
                subtitle: Text(
                  '${activity.activityDate.toLocal()}\n${activity.notes ?? ''}',
                ),
                isThreeLine: activity.notes != null,
                trailing: Text('${activity.durationMinutes} min'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityDialog extends StatefulWidget {
  const _ActivityDialog();
  @override
  State<_ActivityDialog> createState() => _ActivityDialogState();
}

class _ActivityDialogState extends State<_ActivityDialog> {
  final _duration = TextEditingController();
  final _notes = TextEditingController();
  String _type = 'walking';
  @override
  void dispose() {
    _duration.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Add Activity'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButtonFormField<String>(
          initialValue: _type,
          items:
              const [
                    'walking',
                    'running',
                    'cycling',
                    'gym',
                    'yoga',
                    'sports',
                    'other',
                  ]
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
          onChanged: (value) => setState(() => _type = value ?? 'other'),
        ),
        TextField(
          controller: _duration,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(labelText: 'Duration (minutes) *'),
        ),
        TextField(
          controller: _notes,
          decoration: const InputDecoration(labelText: 'Notes'),
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      ElevatedButton(
        onPressed: int.tryParse(_duration.text) == null
            ? null
            : () => Navigator.pop(context, {
                'type': _type,
                'duration': _duration.text,
                'notes': _notes.text,
              }),
        child: const Text('Save'),
      ),
    ],
  );
}
