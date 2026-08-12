import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';

class HealthReportsHelpScreen extends StatelessWidget {
  const HealthReportsHelpScreen({super.key});

  List<Map<String, dynamic>> get _faqs => [
    {
      'question': 'What are health reports?',
      'answer': 'Health reports are summaries of health metrics and activity data collected over a period of time. They provide an overview of vital signs, activity levels, sleep patterns, and other health-related information.',
    },
    {
      'question': 'What is health analytics?',
      'answer': 'Health analytics involves analyzing health data to identify patterns and trends. This can include tracking changes in vital signs, activity levels, sleep quality, and other health metrics over time.',
    },
    {
      'question': 'What does a health report contain?',
      'answer': 'Health reports typically contain key metrics such as heart rate, blood pressure, activity levels, sleep duration, hydration levels, and other relevant health measurements along with historical comparisons.',
    },
    {
      'question': 'How is historical information displayed?',
      'answer': 'Historical information is displayed in chronological order, allowing users to review past health data and identify patterns or changes over time. This can be filtered by category or date range.',
    },
    {
      'question': 'What is a comparison report?',
      'answer': 'A comparison report shows health metrics from two different time periods side by side. This helps users understand changes in their health data between different weeks, months, or other timeframes.',
    },
    {
      'question': 'How should demo reports be interpreted?',
      'answer': 'Demo reports shown in this module are fictional examples for demonstration and educational purposes only. They do not represent real health measurements and should not be used for medical decision-making.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Reports Help'),
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
                  subtitle: 'Health reports guidance',
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
                            'Health reports shown in this module are fictional examples for demonstration and educational purposes only.',
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
