import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/health/health_widgets.dart';

class HealthHomeScreen extends StatelessWidget {
  const HealthHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health & Wellness'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: HealthHeader(),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthSummary);
                  },
                  child: const HealthSummaryCard(
                    overallHealth: 'Good',
                    dailyActivity: '6,420 steps',
                    waterIntake: '5 / 8 glasses',
                    sleep: '7h 20m',
                    exercise: '35 minutes',
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: WaterIntakeCard(
                        current: 5,
                        target: 8,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: SleepTrackerCard(
                        currentSleep: '7h 20m',
                        targetSleep: '8h',
                        quality: 'Good',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: ExerciseTrackerCard(
                  duration: '35 minutes',
                  targetDuration: '30 minutes',
                  activity: 'Walking',
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: HealthGoalsSection(
                  goals: [
                    GoalItem(
                      icon: Icons.directions_walk,
                      title: 'Walk 8,000 steps',
                      current: '6,420',
                      target: '8,000',
                      progress: 0.8,
                    ),
                    GoalItem(
                      icon: Icons.water_drop,
                      title: 'Drink 8 glasses of water',
                      current: '5',
                      target: '8',
                      progress: 0.625,
                    ),
                    GoalItem(
                      icon: Icons.bedtime,
                      title: 'Sleep 8 hours',
                      current: '7h 20m',
                      target: '8h',
                      progress: 0.92,
                    ),
                    GoalItem(
                      icon: Icons.fitness_center,
                      title: 'Exercise 30 minutes',
                      current: '35',
                      target: '30',
                      progress: 1.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthMetrics);
                  },
                  child: Card(
                    color: AppColors.secondaryTeal.withValues(alpha: 0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          const Icon(Icons.analytics, size: 40, color: AppColors.secondaryTeal),
                          const SizedBox(width: AppSpacing.md),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Health Metrics', style: AppTextStyles.title),
                                SizedBox(height: 4),
                                Text('View detailed health metrics'),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.secondaryTeal),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.wellnessTips);
                  },
                  child: Card(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          const Icon(Icons.lightbulb, size: 40, color: AppColors.primaryBlue),
                          const SizedBox(width: AppSpacing.md),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Wellness Tips', style: AppTextStyles.title),
                                SizedBox(height: 4),
                                Text('Explore wellness tips and advice'),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.primaryBlue),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              WellnessTipsSection(
                tips: [
                  TipItem(
                    icon: Icons.water_drop,
                    title: 'Stay Hydrated',
                    description: 'Drink at least 8 glasses of water daily to maintain proper body function.',
                  ),
                  TipItem(
                    icon: Icons.bedtime,
                    title: 'Get Enough Sleep',
                    description: 'Aim for 7-9 hours of quality sleep each night for better health.',
                  ),
                  TipItem(
                    icon: Icons.directions_walk,
                    title: 'Stay Active',
                    description: 'Regular physical activity helps maintain a healthy weight and reduces stress.',
                  ),
                  TipItem(
                    icon: Icons.restaurant,
                    title: 'Eat Balanced Meals',
                    description: 'Include a variety of fruits, vegetables, and whole grains in your diet.',
                  ),
                  TipItem(
                    icon: Icons.self_improvement,
                    title: 'Take Breaks',
                    description: 'Regular breaks during work help maintain productivity and reduce fatigue.',
                  ),
                  TipItem(
                    icon: Icons.spa,
                    title: 'Practice Relaxation',
                    description: 'Mindfulness and relaxation techniques can help manage stress effectively.',
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthEducation);
                  },
                  child: Card(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          const Icon(Icons.school, size: 40, color: AppColors.primaryBlue),
                          const SizedBox(width: AppSpacing.md),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Health Education', style: AppTextStyles.title),
                                SizedBox(height: 4),
                                Text('Learn more about health and wellness'),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.primaryBlue),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthMonitoring);
                  },
                  child: Card(
                    color: AppColors.secondaryTeal.withValues(alpha: 0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          const Icon(Icons.monitor_heart, size: 40, color: AppColors.secondaryTeal),
                          const SizedBox(width: AppSpacing.md),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Health Monitoring', style: AppTextStyles.title),
                                SizedBox(height: 4),
                                Text('Track your health metrics and activity'),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.secondaryTeal),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthReports);
                  },
                  child: Card(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          const Icon(Icons.assessment, size: 40, color: AppColors.primaryBlue),
                          const SizedBox(width: AppSpacing.md),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Health Reports', style: AppTextStyles.title),
                                SizedBox(height: 4),
                                Text('View your health reports and analytics'),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.primaryBlue),
                        ],
                      ),
                    ),
                  ),
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
