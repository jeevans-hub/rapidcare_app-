import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';

class AppointmentDateSelector extends StatelessWidget {
  const AppointmentDateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _DateCard(day: 'Mon', date: '15', isSelected: true),
          SizedBox(width: AppSpacing.sm),
          _DateCard(day: 'Tue', date: '16'),
          SizedBox(width: AppSpacing.sm),
          _DateCard(day: 'Wed', date: '17'),
          SizedBox(width: AppSpacing.sm),
          _DateCard(day: 'Thu', date: '18'),
          SizedBox(width: AppSpacing.sm),
          _DateCard(day: 'Fri', date: '19'),
          SizedBox(width: AppSpacing.sm),
          _DateCard(day: 'Sat', date: '20'),
          SizedBox(width: AppSpacing.sm),
          _DateCard(day: 'Sun', date: '21'),
        ],
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;

  const _DateCard({
    required this.day,
    required this.date,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
