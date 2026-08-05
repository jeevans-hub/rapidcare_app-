import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';
import '../../widgets/section_title.dart';

class PatientSelector extends StatelessWidget {
  const PatientSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Patient'),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: const [
            _PatientOption(
              label: 'Myself',
              isSelected: true,
            ),
            SizedBox(width: AppSpacing.sm),
            _PatientOption(
              label: 'Family Member',
            ),
          ],
        ),
      ],
    );
  }
}

class _PatientOption extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _PatientOption({
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.backgroundLightGreyDark,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? Colors.white : AppColors.textSecondaryGrey,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : AppColors.textPrimaryDarkGrey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
