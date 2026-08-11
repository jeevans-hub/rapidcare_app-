import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/doctors/doctor_widgets.dart';

class DoctorReviewsScreen extends StatelessWidget {
  const DoctorReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Reviews'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryBlue.withValues(alpha: 0.1),
                        AppColors.secondaryTeal.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            '4.8',
                            style: AppTextStyles.title.copyWith(
                              fontSize: 48,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: index < 4
                                    ? AppColors.warningOrange
                                    : AppColors.backgroundLightGrey,
                                size: 20,
                              );
                            }),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '320 Reviews',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondaryGrey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: AppSpacing.xl),
                      Expanded(
                        child: Column(
                          children: [
                            _RatingBar(label: '5 Stars', value: 0.7),
                            _RatingBar(label: '4 Stars', value: 0.2),
                            _RatingBar(label: '3 Stars', value: 0.05),
                            _RatingBar(label: '2 Stars', value: 0.03),
                            _RatingBar(label: '1 Star', value: 0.02),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                DoctorReviewsSection(
                  reviews: [
                    ReviewItem(
                      patientName: 'John Smith',
                      rating: 5.0,
                      date: 'Aug 10, 2026',
                      reviewText: 'Dr. Sarah is an excellent cardiologist. She explained everything clearly and the treatment was very effective. Highly recommended!',
                    ),
                    ReviewItem(
                      patientName: 'Emily Johnson',
                      rating: 5.0,
                      date: 'Aug 8, 2026',
                      reviewText: 'Very professional and caring. Took the time to understand my concerns and provided excellent care.',
                    ),
                    ReviewItem(
                      patientName: 'Michael Brown',
                      rating: 4.5,
                      date: 'Aug 5, 2026',
                      reviewText: 'Great experience overall. The doctor was knowledgeable and the staff was helpful.',
                    ),
                    ReviewItem(
                      patientName: 'Sarah Davis',
                      rating: 5.0,
                      date: 'Aug 2, 2026',
                      reviewText: 'Dr. Sarah is amazing! She diagnosed my condition quickly and the treatment plan worked perfectly.',
                    ),
                    ReviewItem(
                      patientName: 'Robert Wilson',
                      rating: 4.0,
                      date: 'Jul 30, 2026',
                      reviewText: 'Good doctor, but the waiting time was a bit long. Otherwise, excellent service.',
                    ),
                    ReviewItem(
                      patientName: 'Lisa Anderson',
                      rating: 5.0,
                      date: 'Jul 28, 2026',
                      reviewText: 'Best cardiologist I\'ve ever visited. Very thorough and compassionate.',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RatingBar extends StatelessWidget {
  final String label;
  final double value;

  const _RatingBar({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: AppTextStyles.caption,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: AppColors.backgroundLightGrey,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.warningOrange),
              minHeight: 6,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            width: 30,
            child: Text(
              '${(value * 100).toInt()}%',
              style: AppTextStyles.caption,
            ),
          ),
        ],
      ),
    );
  }
}
