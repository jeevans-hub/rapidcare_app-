import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import 'emergency_action_dialogs.dart';

class SOSButton extends StatelessWidget {
  const SOSButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => EmergencyActionDialogs.showSosConfirmation(context),
          onLongPress: () => EmergencyActionDialogs.showSosConfirmation(context),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.errorRed,
                  AppColors.errorRedDark,
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.errorRed.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.emergency,
              size: 48,
              color: AppColors.white,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'SOS',
          style: AppTextStyles.title.copyWith(
            color: AppColors.errorRed,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'For real emergencies only',
          style: AppTextStyles.small,
        ),
      ],
    );
  }
}
