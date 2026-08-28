import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import 'time_slot_card.dart';

class TimeSlotSection extends StatefulWidget {
  final List<String>? availableSlots;
  final ValueChanged<String>? onSlotSelected;

  const TimeSlotSection({super.key, this.availableSlots, this.onSlotSelected});

  @override
  State<TimeSlotSection> createState() => _TimeSlotSectionState();
}

class _TimeSlotSectionState extends State<TimeSlotSection> {
  String? selectedSlot;

  @override
  Widget build(BuildContext context) {
    final slots = widget.availableSlots ?? [
      '09:00 AM',
      '09:30 AM',
      '10:00 AM',
      '10:30 AM',
      '11:00 AM',
      '11:30 AM',
      '02:00 PM',
      '02:30 PM',
      '03:00 PM',
      '03:30 PM',
      '04:00 PM',
      '04:30 PM',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Available Time Slots'),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: slots.map((slot) {
            return TimeSlotCard(
              time: slot,
              isSelected: selectedSlot == slot,
              onTap: () {
                setState(() {
                  selectedSlot = slot;
                });
                widget.onSlotSelected?.call(slot);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
