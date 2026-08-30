import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import 'emergency_contact_card.dart';
import 'emergency_action_dialogs.dart';

class EmergencyContactsSection extends StatelessWidget {
  const EmergencyContactsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'My Emergency Contacts',
          subtitle: 'Quick access to your emergency contacts',
        ),
        const SizedBox(height: AppSpacing.md),
        EmergencyContactCard(
          name: 'John Doe',
          relationship: 'Spouse',
          phoneNumber: '+1 234 567 8900',
          onCall: () => EmergencyActionDialogs.showContactInfo(context, 'Call Contact'),
          onMessage: () => EmergencyActionDialogs.showContactInfo(context, 'Message Contact'),
        ),
        const SizedBox(height: AppSpacing.sm),
        EmergencyContactCard(
          name: 'Jane Smith',
          relationship: 'Parent',
          phoneNumber: '+1 234 567 8901',
          onCall: () => EmergencyActionDialogs.showContactInfo(context, 'Call Contact'),
          onMessage: () => EmergencyActionDialogs.showContactInfo(context, 'Message Contact'),
        ),
        const SizedBox(height: AppSpacing.sm),
        EmergencyContactCard(
          name: 'Mike Johnson',
          relationship: 'Sibling',
          phoneNumber: '+1 234 567 8902',
          onCall: () => EmergencyActionDialogs.showContactInfo(context, 'Call Contact'),
          onMessage: () => EmergencyActionDialogs.showContactInfo(context, 'Message Contact'),
        ),
        const SizedBox(height: AppSpacing.md),
        ElevatedButton.icon(
          onPressed: () => EmergencyActionDialogs.showDemoUnavailable(
            context,
            'Add Contact',
            'Emergency contact management is not connected to a live service in this demo.',
          ),
          icon: const Icon(Icons.add),
          label: const Text('Add Contact'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
          ),
        ),
      ],
    );
  }
}
