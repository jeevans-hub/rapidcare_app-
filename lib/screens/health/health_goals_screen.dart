import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/health/health_widgets.dart';

class HealthGoalsScreen extends StatelessWidget {
  const HealthGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Goals'),
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
                  subtitle: 'Track your daily wellness targets',
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
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
