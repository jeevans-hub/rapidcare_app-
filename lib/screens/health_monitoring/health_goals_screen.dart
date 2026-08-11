import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_monitoring/health_monitoring_widgets.dart';

class HealthGoalsScreen extends StatelessWidget {
  const HealthGoalsScreen({super.key});

  List<Map<String, dynamic>> get _goals => [
    {
      'goalName': 'Daily Steps',
      'current': '6,420',
      'target': '8,000',
      'progress': 0.80,
      'status': 'On Track',
      'icon': Icons.directions_walk,
    },
    {
      'goalName': 'Water Intake',
      'current': '5 / 8',
      'target': '8 glasses',
      'progress': 0.62,
      'status': 'In Progress',
      'icon': Icons.water_drop,
    },
    {
      'goalName': 'Sleep',
      'current': '7h 20m',
      'target': '8 hours',
      'progress': 0.92,
      'status': 'On Track',
      'icon': Icons.bedtime,
    },
    {
      'goalName': 'Active Minutes',
      'current': '24',
      'target': '30 min',
      'progress': 0.80,
      'status': 'In Progress',
      'icon': Icons.fitness_center,
    },
    {
      'goalName': 'Weekly Activity',
      'current': '5',
      'target': '5 days',
      'progress': 1.0,
      'status': 'Completed',
      'icon': Icons.event,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Goals'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Health Goals',
                  subtitle: 'Demo goal tracking',
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
                            'Demo data only. Goal progress is sample data and exists only during the current session.',
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
                      itemCount: _goals.length,
                      itemBuilder: (context, index) {
                        final goal = _goals[index];
                        return HealthGoalCard(
                          goalName: goal['goalName'],
                          current: goal['current'],
                          target: goal['target'],
                          progress: goal['progress'],
                          status: goal['status'],
                          icon: goal['icon'],
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
