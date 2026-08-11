import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import 'doctor_review_card.dart';

class DoctorReviewsSection extends StatelessWidget {
  final List<ReviewItem> reviews;
  final VoidCallback? onViewAll;

  const DoctorReviewsSection({
    super.key,
    required this.reviews,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionTitle(title: 'Reviews'),
            if (onViewAll != null)
              TextButton(
                onPressed: onViewAll,
                child: const Text('View All'),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ...reviews.map((review) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: DoctorReviewCard(
              patientName: review.patientName,
              rating: review.rating,
              date: review.date,
              reviewText: review.reviewText,
            ),
          );
        }),
      ],
    );
  }
}

class ReviewItem {
  final String patientName;
  final double rating;
  final String date;
  final String reviewText;

  ReviewItem({
    required this.patientName,
    required this.rating,
    required this.date,
    required this.reviewText,
  });
}
