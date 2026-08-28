import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';

class AppointmentDateSelector extends StatefulWidget {
  final ValueChanged<String>? onDateSelected;

  const AppointmentDateSelector({super.key, this.onDateSelected});

  @override
  State<AppointmentDateSelector> createState() => _AppointmentDateSelectorState();
}

class _AppointmentDateSelectorState extends State<AppointmentDateSelector> {
  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _DateCard(
            day: 'Mon',
            date: '15',
            isSelected: selectedDate == '2026-01-15',
            onTap: () => _selectDate('2026-01-15'),
          ),
          const SizedBox(width: AppSpacing.sm),
          _DateCard(
            day: 'Tue',
            date: '16',
            isSelected: selectedDate == '2026-01-16',
            onTap: () => _selectDate('2026-01-16'),
          ),
          const SizedBox(width: AppSpacing.sm),
          _DateCard(
            day: 'Wed',
            date: '17',
            isSelected: selectedDate == '2026-01-17',
            onTap: () => _selectDate('2026-01-17'),
          ),
          const SizedBox(width: AppSpacing.sm),
          _DateCard(
            day: 'Thu',
            date: '18',
            isSelected: selectedDate == '2026-01-18',
            onTap: () => _selectDate('2026-01-18'),
          ),
          const SizedBox(width: AppSpacing.sm),
          _DateCard(
            day: 'Fri',
            date: '19',
            isSelected: selectedDate == '2026-01-19',
            onTap: () => _selectDate('2026-01-19'),
          ),
          const SizedBox(width: AppSpacing.sm),
          _DateCard(
            day: 'Sat',
            date: '20',
            isSelected: selectedDate == '2026-01-20',
            onTap: () => _selectDate('2026-01-20'),
          ),
          const SizedBox(width: AppSpacing.sm),
          _DateCard(
            day: 'Sun',
            date: '21',
            isSelected: selectedDate == '2026-01-21',
            onTap: () => _selectDate('2026-01-21'),
          ),
        ],
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
            color: isSelected ? AppColors.primaryBlue : AppColors.backgroundLightGreyDark,
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
                color: isSelected ? Colors.white : AppColors.textPrimaryDarkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
