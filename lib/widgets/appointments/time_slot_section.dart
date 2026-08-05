import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import 'time_slot_card.dart';

class TimeSlotSection extends StatelessWidget {
  const TimeSlotSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Available Time Slots'),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: const [
            TimeSlotCard(time: '09:00 AM', isSelected: true),
            TimeSlotCard(time: '09:30 AM'),
            TimeSlotCard(time: '10:00 AM'),
            TimeSlotCard(time: '10:30 AM'),
            TimeSlotCard(time: '11:00 AM'),
            TimeSlotCard(time: '11:30 AM', isAvailable: false),
            TimeSlotCard(time: '02:00 PM'),
            TimeSlotCard(time: '02:30 PM'),
            TimeSlotCard(time: '03:00 PM'),
            TimeSlotCard(time: '03:30 PM'),
            TimeSlotCard(time: '04:00 PM'),
            TimeSlotCard(time: '04:30 PM'),
          ],
        ),
      ],
    );
  }
}
