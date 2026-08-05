import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';
import '../../widgets/section_title.dart';

class ConsultationTypeSelector extends StatelessWidget {
  const ConsultationTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Consultation Type'),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: const [
            _ConsultationTypeCard(
              icon: Icons.video_call,
              title: 'Video Consultation',
              isSelected: true,
            ),
            SizedBox(width: AppSpacing.sm),
            _ConsultationTypeCard(
              icon: Icons.location_on,
              title: 'Clinic Visit',
            ),
            SizedBox(width: AppSpacing.sm),
            _ConsultationTypeCard(
              icon: Icons.home,
              title: 'Home Visit',
            ),
          ],
        ),
      ],
    );
  }
}

class _ConsultationTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;

  const _ConsultationTypeCard({
    required this.icon,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue.withValues(alpha: 0.1) : AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.backgroundLightGreyDark,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primaryBlue : AppColors.textSecondaryGrey,
              size: 24,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? AppColors.primaryBlue : AppColors.textPrimaryDarkGrey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
