import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';

class WellnessResourcesScreen extends StatelessWidget {
  WellnessResourcesScreen({super.key});

  final List<Map<String, dynamic>> _resources = [
    {
      'title': 'Healthy Lifestyle Basics',
      'description': 'Foundational information about maintaining a healthy lifestyle through balanced habits.',
      'category': 'General Wellness',
      'resourceType': 'Article',
      'icon': Icons.article,
    },
    {
      'title': 'Nutrition Basics',
      'description': 'Understanding macronutrients, micronutrients, and balanced eating principles.',
      'category': 'Nutrition',
      'resourceType': 'Guide',
      'icon': Icons.restaurant,
    },
    {
      'title': 'Sleep & Recovery',
      'description': 'Information about sleep cycles, sleep hygiene, and recovery importance.',
      'category': 'Sleep',
      'resourceType': 'Article',
      'icon': Icons.bedtime,
    },
    {
      'title': 'Exercise Awareness',
      'description': 'Types of physical activity, exercise guidelines, and fitness fundamentals.',
      'category': 'Exercise',
      'resourceType': 'Guide',
      'icon': Icons.fitness_center,
    },
    {
      'title': 'Stress Management',
      'description': 'Techniques for managing everyday stress and maintaining mental wellness.',
      'category': 'Mental Wellness',
      'resourceType': 'Article',
      'icon': Icons.psychology,
    },
    {
      'title': 'Preventive Care',
      'description': 'Understanding preventive health measures, screenings, and vaccinations.',
      'category': 'Preventive Care',
      'resourceType': 'Guide',
      'icon': Icons.vaccines,
    },
    {
      'title': 'Healthy Aging',
      'description': 'Health considerations and wellness strategies for healthy aging.',
      'category': 'Healthy Aging',
      'resourceType': 'Article',
      'icon': Icons.elderly,
    },
    {
      'title': 'General Wellness',
      'description': 'Comprehensive overview of wellness across multiple health dimensions.',
      'category': 'General Wellness',
      'resourceType': 'Guide',
      'icon': Icons.favorite,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness Resources'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Wellness Resources',
                  subtitle: 'Educational resources for better health',
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
                            'Educational resources only. Consult healthcare professionals for personalized advice.',
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
                        childAspectRatio: 1.5,
                      ),
                      itemCount: _resources.length,
                      itemBuilder: (context, index) {
                        final resource = _resources[index];
                        return InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${resource['title']}: ${resource['description']}',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(AppRadius.large),
                          splashColor: AppColors.primaryBlueLight.withValues(alpha: 0.3),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppRadius.large),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    resource['icon'],
                                    size: 32,
                                    color: AppColors.primaryBlue,
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  Text(
                                    resource['title'],
                                    style: AppTextStyles.title,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    resource['description'],
                                    style: AppTextStyles.caption,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSpacing.sm,
                                          vertical: AppSpacing.xs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryBlueLight.withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(AppRadius.small),
                                        ),
                                        child: Text(
                                          resource['category'],
                                          style: AppTextStyles.small,
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSpacing.sm,
                                          vertical: AppSpacing.xs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryTeal.withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(AppRadius.small),
                                        ),
                                        child: Text(
                                          resource['resourceType'],
                                          style: AppTextStyles.small,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
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
