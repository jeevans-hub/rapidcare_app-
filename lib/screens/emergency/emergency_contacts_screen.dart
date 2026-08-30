import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/emergency/emergency_action_dialogs.dart';

class EmergencyContactsScreen extends StatelessWidget {
  const EmergencyContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Emergency Contacts',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Quick access to your emergency contacts',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildContactCard(
                context: context,
                name: 'John Doe',
                relationship: 'Spouse',
                phone: '+1 234 567 8900',
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildContactCard(
                context: context,
                name: 'Jane Smith',
                relationship: 'Parent',
                phone: '+1 234 567 8901',
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildContactCard(
                context: context,
                name: 'Mike Johnson',
                relationship: 'Sibling',
                phone: '+1 234 567 8902',
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildContactCard(
                context: context,
                name: 'Sarah Williams',
                relationship: 'Friend',
                phone: '+1 234 567 8903',
              ),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showAddContactDialog(context);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Contact'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required BuildContext context,
    required String name,
    required String relationship,
    required String phone,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                name[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    relationship,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    phone,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => EmergencyActionDialogs.showDemoUnavailable(
                context,
                'Edit Contact',
                'Emergency contact management is not connected to a live service in this demo.',
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => EmergencyActionDialogs.showDemoUnavailable(
                context,
                'Delete Contact',
                'Emergency contact management is not connected to a live service in this demo.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Emergency Contact'),
        content: const Text('Add contact functionality placeholder'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
