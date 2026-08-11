import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/health/health_widgets.dart';

class WellnessTipsScreen extends StatelessWidget {
  const WellnessTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness Tips'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: HealthHeader(
                  subtitle: 'Daily wellness guidance for a healthier life',
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: WellnessTipsSection(
                  tips: [
                    TipItem(
                      icon: Icons.water_drop,
                      title: 'Stay Hydrated',
                      description: 'Drink at least 8 glasses of water daily to maintain proper body function and energy levels.',
                    ),
                    TipItem(
                      icon: Icons.bedtime,
                      title: 'Get Enough Sleep',
                      description: 'Aim for 7-9 hours of quality sleep each night for better health and cognitive function.',
                    ),
                    TipItem(
                      icon: Icons.directions_walk,
                      title: 'Stay Active',
                      description: 'Regular physical activity helps maintain a healthy weight and reduces stress levels.',
                    ),
                    TipItem(
                      icon: Icons.restaurant,
                      title: 'Eat Balanced Meals',
                      description: 'Include a variety of fruits, vegetables, and whole grains in your daily diet.',
                    ),
                    TipItem(
                      icon: Icons.self_improvement,
                      title: 'Take Breaks',
                      description: 'Regular breaks during work help maintain productivity and reduce mental fatigue.',
                    ),
                    TipItem(
                      icon: Icons.spa,
                      title: 'Practice Relaxation',
                      description: 'Mindfulness and relaxation techniques can help manage stress effectively.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Additional Resources',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _ResourceCard(
                      icon: Icons.book,
                      title: 'Health Articles',
                      description: 'Read more about health and wellness topics.',
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _ResourceCard(
                      icon: Icons.video_library,
                      title: 'Exercise Videos',
                      description: 'Watch guided exercise routines.',
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _ResourceCard(
                      icon: Icons.restaurant_menu,
                      title: 'Healthy Recipes',
                      description: 'Discover nutritious meal ideas.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ResourceCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: 24,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
