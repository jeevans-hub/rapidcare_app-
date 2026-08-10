import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final VoidCallback? onEditTap;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppRadius.large),
          bottomRight: Radius.circular(AppRadius.large),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.surfaceWhite,
                width: 3,
              ),
            ),
            child: const Icon(
              Icons.person,
              size: 48,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            name,
            style: AppTextStyles.title.copyWith(
              color: AppColors.white,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            email,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.surfaceWhite,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          PrimaryButton(
            text: 'Edit Profile',
            onPressed: onEditTap,
          ),
        ],
      ),
    );
  }
}
