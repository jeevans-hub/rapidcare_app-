import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class DoctorRatingWidget extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const DoctorRatingWidget({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: AppColors.warningOrange, size: 16),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '($reviewCount)',
          style: const TextStyle(
            color: AppColors.textSecondaryGrey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
