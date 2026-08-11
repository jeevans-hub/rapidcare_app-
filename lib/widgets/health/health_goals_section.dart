import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import 'health_goal_card.dart';

class HealthGoalsSection extends StatelessWidget {
  final List<GoalItem> goals;

  const HealthGoalsSection({
    super.key,
    required this.goals,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Daily Goals'),
        const SizedBox(height: AppSpacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: crossAxisCount == 2 ? 2.5 : 3.0,
              children: goals.map((goal) {
                return HealthGoalCard(
                  icon: goal.icon,
                  title: goal.title,
                  current: goal.current,
                  target: goal.target,
                  progress: goal.progress,
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class GoalItem {
  final IconData icon;
  final String title;
  final String current;
  final String target;
  final double progress;

  GoalItem({
    required this.icon,
    required this.title,
    required this.current,
    required this.target,
    required this.progress,
  });
}
