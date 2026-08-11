import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_education/health_education_widgets.dart';

class HealthTipsScreen extends StatelessWidget {
  HealthTipsScreen({super.key});

  final List<Map<String, dynamic>> _tips = [
    {
      'icon': Icons.water_drop,
      'title': 'Stay Hydrated',
      'description': 'Drink adequate water throughout the day to support bodily functions and maintain energy levels.',
      'category': 'Nutrition',
    },
    {
      'icon': Icons.fitness_center,
      'title': 'Regular Physical Activity',
      'description': 'Engage in moderate exercise regularly to maintain cardiovascular health and muscle strength.',
      'category': 'Exercise',
    },
    {
      'icon': Icons.restaurant,
      'title': 'Balanced Eating Habits',
      'description': 'Include a variety of food groups in your diet for proper nutrition and overall wellness.',
      'category': 'Nutrition',
    },
    {
      'icon': Icons.bedtime,
      'title': 'Regular Sleep Routine',
      'description': 'Maintain consistent sleep and wake times to support natural circadian rhythms.',
      'category': 'Sleep',
    },
    {
      'icon': Icons.clean_hands,
      'title': 'Basic Hygiene',
      'description': 'Practice regular hand washing and personal hygiene to prevent illness.',
      'category': 'General Wellness',
    },
    {
      'icon': Icons.calendar_today,
      'title': 'Routine Checkups',
      'description': 'Schedule regular health screenings and checkups for preventive care.',
      'category': 'Preventive Care',
    },
    {
      'icon': Icons.directions_walk,
      'title': 'Movement Breaks',
      'description': 'Take short breaks from sitting to move and stretch throughout the day.',
      'category': 'Exercise',
    },
    {
      'icon': Icons.psychology,
      'title': 'Stress Management',
      'description': 'Practice relaxation techniques and healthy coping strategies for stress.',
      'category': 'Mental Wellness',
    },
    {
      'icon': Icons.smoke_free,
      'title': 'Avoid Tobacco',
      'description': 'Avoid tobacco products and exposure to secondhand smoke for better health.',
      'category': 'General Wellness',
    },
    {
      'icon': Icons.wb_sunny,
      'title': 'Sun Safety',
      'description': 'Use sun protection and limit excessive sun exposure to protect skin health.',
      'category': 'General Wellness',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Tips'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Preventive Wellness Tips',
                  subtitle: 'General wellness information only',
                ),
                const SizedBox(height: AppSpacing.lg),
                Card(
                  color: AppColors.warningOrange.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: AppColors.warningOrange),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'General wellness information only. Consult healthcare professionals for personalized advice.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                    
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: AppSpacing.md,
                        crossAxisSpacing: AppSpacing.md,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: _tips.length,
                      itemBuilder: (context, index) {
                        final tip = _tips[index];
                        return HealthTipCard(
                          icon: tip['icon'],
                          title: tip['title'],
                          description: tip['description'],
                          category: tip['category'],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
