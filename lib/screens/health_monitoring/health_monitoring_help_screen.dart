import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';

class HealthMonitoringHelpScreen extends StatelessWidget {
  const HealthMonitoringHelpScreen({super.key});

  List<Map<String, dynamic>> get _faqs => [
    {
      'question': 'What is health monitoring?',
      'answer': 'Health monitoring involves tracking and measuring various health metrics over time to understand patterns and trends in your health data. This includes vital signs, activity levels, sleep quality, and other wellness indicators.',
    },
    {
      'question': 'What are vital signs?',
      'answer': 'Vital signs are measurements of the body\'s basic functions. Common vital signs include heart rate, blood pressure, blood oxygen saturation, temperature, and respiratory rate. These measurements provide important information about a person\'s physiological state.',
    },
    {
      'question': 'What is activity tracking?',
      'answer': 'Activity tracking involves monitoring physical movement and exercise. This can include steps taken, distance walked or run, active minutes, calories burned, and other exercise-related metrics. Activity tracking helps assess physical activity levels.',
    },
    {
      'question': 'What does historical health data mean?',
      'answer': 'Historical health data shows patterns and trends in your health metrics over time. This information can help identify changes in health status, track progress toward goals, and provide context for discussions with healthcare professionals.',
    },
    {
      'question': 'How does health monitoring work?',
      'answer': 'Health monitoring can be done through various methods including wearable devices, smartphone sensors, manual entry, and connected health devices. The collected data is stored and displayed to help users understand their health patterns.',
    },
    {
      'question': 'What are health goals?',
      'answer': 'Health goals are targets set for maintaining or improving health. Examples include daily step targets, sleep duration goals, water intake goals, and exercise targets. Goals help maintain motivation and track progress toward healthier habits.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Monitoring Help'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Help & Information',
                  subtitle: 'Health monitoring guidance',
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
                            'Health monitoring information shown in this module is for demonstration and educational purposes only.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                ..._faqs.map((faq) => Card(
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.help_outline,
                        color: AppColors.primaryBlue,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      faq['question'],
                      style: AppTextStyles.subtitle,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Text(
                          faq['answer'],
                          style: AppTextStyles.caption,
                        ),
                      ),
                    ],
                  ),
                )),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
