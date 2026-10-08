import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';

class AppointmentDateSelector extends StatefulWidget {
  final ValueChanged<String>? onDateSelected;

  const AppointmentDateSelector({super.key, this.onDateSelected});

  @override
  State<AppointmentDateSelector> createState() =>
      _AppointmentDateSelectorState();
}

class _AppointmentDateSelectorState extends State<AppointmentDateSelector> {
  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(7, (index) {
          final now = DateTime.now();
          final date = DateTime(now.year, now.month, now.day + index);
          final value =
              '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
          const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: _DateCard(
              day: weekdays[date.weekday - 1],
              date: date.day.toString(),
              isSelected: selectedDate == value,
              onTap: () => _selectDate(value),
            ),
          );
        }),
      ),
    );
  }

  void _selectDate(String date) {
    setState(() {
      selectedDate = date;
    });
    widget.onDateSelected?.call(date);
  }
}

class _DateCard extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  final VoidCallback? onTap;

  const _DateCard({
    required this.day,
    required this.date,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryBlue
                : AppColors.backgroundLightGreyDark,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? Colors.white : AppColors.textSecondaryGrey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Colors.white
                    : AppColors.textPrimaryDarkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
