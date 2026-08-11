import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/health/health_widgets.dart';

class HealthSummaryScreen extends StatelessWidget {
  const HealthSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Overview'),
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
                  subtitle: 'Your weekly health summary',
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: HealthSummaryCard(
                  overallHealth: 'Good',
                  dailyActivity: '6,420 steps',
                  waterIntake: '5 / 8 glasses',
                  sleep: '7h 20m',
                  exercise: '35 minutes',
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Text(
                  'Weekly Overview',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    HealthProgressCard(
                      title: 'Activity',
                      value: '45,000',
                      unit: 'steps',
                      progress: 0.75,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    HealthProgressCard(
                      title: 'Water',
                      value: '42',
                      unit: 'glasses',
                      progress: 0.75,
                      color: Colors.cyan,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    HealthProgressCard(
                      title: 'Sleep',
                      value: '52',
                      unit: 'hours',
                      progress: 0.93,
                      color: Colors.purple,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    HealthProgressCard(
                      title: 'Exercise',
                      value: '245',
                      unit: 'minutes',
                      progress: 1.0,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Weekly Achievements',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _AchievementItem(
                        icon: Icons.check_circle,
                        title: 'Completed 5 days of exercise',
                        achieved: true,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _AchievementItem(
                        icon: Icons.check_circle,
                        title: 'Met water intake goal 4 days',
                        achieved: true,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _AchievementItem(
                        icon: Icons.radio_button_unchecked,
                        title: 'Reached step goal 3 days',
                        achieved: false,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _AchievementItem(
                        icon: Icons.check_circle,
                        title: 'Maintained sleep schedule',
                        achieved: true,
                      ),
                    ],
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

class _AchievementItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool achieved;

  const _AchievementItem({
    required this.icon,
    required this.title,
    required this.achieved,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: achieved ? Colors.green : Colors.grey,
          size: 20,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: achieved ? Colors.black87 : Colors.grey,
              decoration: achieved ? null : TextDecoration.lineThrough,
            ),
          ),
        ),
      ],
    );
  }
}
