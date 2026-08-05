import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';
import 'doctor_rating_widget.dart';

class DoctorCard extends StatelessWidget {
  final String doctorName;
  final String qualification;
  final String specialization;
  final String hospital;
  final int experience;
  final double rating;
  final int reviewCount;
  final int fee;
  final bool isAvailableToday;
  final VoidCallback? onTap;

  const DoctorCard({
    super.key,
    required this.doctorName,
    required this.qualification,
    required this.specialization,
    required this.hospital,
    required this.experience,
    required this.rating,
    required this.reviewCount,
    required this.fee,
    this.isAvailableToday = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.large),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(AppRadius.large),
          border: Border.all(color: AppColors.backgroundLightGreyDark),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
              child: const Icon(
                Icons.person,
                size: 32,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    qualification,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryGrey,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    specialization,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  DoctorRatingWidget(
                    rating: rating,
                    reviewCount: reviewCount,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.local_hospital, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          hospital,
                          style: const TextStyle(fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        '₹$fee',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            if (isAvailableToday)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.small),
                ),
                child: const Text(
                  'Available',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.successGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
