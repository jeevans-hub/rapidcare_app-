import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_education/health_education_widgets.dart';

class HealthFaqScreen extends StatelessWidget {
  HealthFaqScreen({super.key});

  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'What is preventive healthcare?',
      'answer': 'Preventive healthcare focuses on disease prevention and health promotion before illness occurs. It includes regular checkups, screenings, vaccinations, and lifestyle modifications to maintain health and detect issues early.',
    },
    {
      'question': 'Why are regular health checkups important?',
      'answer': 'Regular health checkups help detect potential health issues early when they are most treatable. They allow healthcare providers to monitor your health over time and provide personalized recommendations for maintaining wellness.',
    },
    {
      'question': 'What is a balanced diet?',
      'answer': 'A balanced diet includes a variety of foods from all food groups in appropriate proportions. It provides essential nutrients, vitamins, and minerals needed for optimal health and supports proper body function.',
    },
    {
      'question': 'Why is sleep important?',
      'answer': 'Quality sleep is essential for physical and mental health. It allows the body to repair tissues, supports immune function, helps with memory consolidation, and regulates hormones that affect appetite and stress.',
    },
    {
      'question': 'How does regular physical activity support health?',
      'answer': 'Regular physical activity strengthens the heart, improves circulation, helps maintain healthy weight, strengthens bones and muscles, reduces stress, and improves mental health and cognitive function.',
    },
    {
      'question': 'What is health screening?',
      'answer': 'Health screening involves tests or examinations to detect diseases or health conditions before symptoms appear. Examples include blood pressure checks, cholesterol tests, cancer screenings, and diabetes screenings.',
    },
    {
      'question': 'What is first aid?',
      'answer': 'First aid is the immediate assistance given to someone who is injured or suddenly ill. It is intended to preserve life, prevent the condition from worsening, and promote recovery until professional medical help arrives.',
    },
    {
      'question': 'When should someone seek professional medical help?',
      'answer': 'Seek professional medical help for persistent symptoms, severe pain, difficulty breathing, chest pain, sudden changes in health status, or any concerning symptoms. Early consultation can lead to better outcomes.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health FAQ'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Frequently Asked Questions',
                  subtitle: 'Common health education questions',
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
                            'Educational information only. Consult healthcare professionals for personalized medical advice.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                ..._faqs.map((faq) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: FaqHealthCard(
                    question: faq['question'],
                    answer: faq['answer'],
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
