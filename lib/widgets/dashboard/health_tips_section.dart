import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import '../../core/routes/app_routes.dart';
import 'health_tip_card.dart';

class HealthTipsSection extends StatelessWidget {
  const HealthTipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Health Tips'),
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HealthTipCard(
                  icon: Icons.nights_stay,
                  title: 'Sleep Better',
                  description:
                      'Get 7-8 hours of quality sleep for better health.',
                  onReadMore: () => Navigator.pushNamed(
                    context,
                    AppRoutes.healthArticleDetails,
                    arguments: {
                      'id': 'healthy-sleep-habits',
                      'content':
                          'Get 7-8 hours of quality sleep for better health.',
                      'title': 'Healthy Sleep Habits',
                      'category': 'Sleep',
                      'readingTime': '6 min read',
                      'icon': Icons.bedtime,
                    },
                  ),
                ),
                SizedBox(width: AppSpacing.md),
                HealthTipCard(
                  icon: Icons.water_drop,
                  title: 'Stay Hydrated',
                  description: 'Drink at least 8 glasses of water daily.',
                  onReadMore: () => Navigator.pushNamed(
                    context,
                    AppRoutes.healthArticleDetails,
                    arguments: {
                      'id': 'staying-hydrated',
                      'content': 'Drink at least 8 glasses of water daily.',
                      'title': 'Staying Hydrated',
                      'category': 'Nutrition',
                      'readingTime': '3 min read',
                      'icon': Icons.water_drop,
                    },
                  ),
                ),
                HealthTipCard(
                  icon: Icons.directions_run,
                  title: 'Exercise Daily',
                  description: '30 minutes of exercise keeps you fit.',
                  onReadMore: () => Navigator.pushNamed(
                    context,
                    AppRoutes.healthArticleDetails,
                    arguments: {
                      'id': 'regular-exercise',
                      'content': '30 minutes of exercise keeps you fit.',
                      'title': 'Importance of Regular Exercise',
                      'category': 'Exercise',
                      'readingTime': '4 min read',
                      'icon': Icons.directions_run,
                    },
                  ),
                ),
                HealthTipCard(
                  icon: Icons.restaurant,
                  title: 'Eat Healthy',
                  description: 'Include fruits and vegetables in your diet.',
                  onReadMore: () => Navigator.pushNamed(
                    context,
                    AppRoutes.healthArticleDetails,
                    arguments: {
                      'id': 'balanced-nutrition',
                      'content': 'Include fruits and vegetables in your diet.',
                      'title': 'Understanding Balanced Nutrition',
                      'category': 'Nutrition',
                      'readingTime': '8 min read',
                      'icon': Icons.restaurant,
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
