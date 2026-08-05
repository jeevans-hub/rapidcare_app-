import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
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
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                HealthTipCard(
                  icon: Icons.nights_stay,
                  title: 'Sleep Better',
                  description: 'Get 7-8 hours of quality sleep for better health.',
                ),
                SizedBox(width: AppSpacing.md),
                HealthTipCard(
                  icon: Icons.water_drop,
                  title: 'Stay Hydrated',
                  description: 'Drink at least 8 glasses of water daily.',
                ),
                HealthTipCard(
                  icon: Icons.directions_run,
                  title: 'Exercise Daily',
                  description: '30 minutes of exercise keeps you fit.',
                ),
                HealthTipCard(
                  icon: Icons.restaurant,
                  title: 'Eat Healthy',
                  description: 'Include fruits and vegetables in your diet.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
