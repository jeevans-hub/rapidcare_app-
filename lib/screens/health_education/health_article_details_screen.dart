import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_education/health_education_widgets.dart';

class HealthArticleDetailsScreen extends StatelessWidget {
  const HealthArticleDetailsScreen({super.key});

  // Stable IDs select the existing local articles independently of display text.
  static const _articleTitles = {
    'healthy-sleep-habits': 'Healthy Sleep Habits',
    'staying-hydrated': 'Staying Hydrated',
    'regular-exercise': 'Importance of Regular Exercise',
    'balanced-nutrition': 'Understanding Balanced Nutrition',
    'blood-pressure': 'Understanding Blood Pressure',
  };

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final article = arguments is Map ? arguments : const {};
    final id = article['id'];
    final title = article['title'] is String ? article['title'] as String : '';
    // Keep title-only links from Health Education compatible. An unknown ID
    // must never silently select a different article by title.
    final contentTitle = id != null
        ? _articleTitles[id]
        : (_articleTitles.containsValue(title) ? title : null);
    final availableContent = article['content'] ?? article['description'];

    return Scaffold(
      appBar: AppBar(title: const Text('Article Details')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      article['icon'] is IconData
                          ? article['icon'] as IconData
                          : Icons.article,
                      size: 64,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  title.isNotEmpty ? title : 'Article unavailable',
                  style: AppTextStyles.headline,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlueLight.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                    ),
                    child: Text(
                      article['category']?.toString() ?? 'Unknown',
                      style: AppTextStyles.caption,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                HealthEducationInfoCard(
                  icon: Icons.access_time,
                  title: 'Reading Time',
                  content:
                      article['readingTime']?.toString() ?? 'Not Specified',
                ),
                const SizedBox(height: AppSpacing.md),
                if (contentTitle == null) ...[
                  if (availableContent is String &&
                      availableContent.trim().isNotEmpty)
                    Text(availableContent, style: AppTextStyles.body),
                  const SizedBox(height: AppSpacing.md),
                  const Text(
                    'Full article unavailable',
                    style: AppTextStyles.body,
                  ),
                ] else ...[
                  const SectionTitle(title: 'Introduction'),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _getArticleIntroduction(contentTitle),
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const SectionTitle(title: 'Why It Matters'),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _getWhyItMatters(contentTitle),
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const SectionTitle(title: 'Healthy Habits'),
                  const SizedBox(height: AppSpacing.sm),
                  ..._getHealthyHabits(contentTitle).map(
                    (habit) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: AppTextStyles.body),
                          Expanded(
                            child: Text(habit, style: AppTextStyles.body),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const SectionTitle(title: 'Prevention Basics'),
                  const SizedBox(height: AppSpacing.sm),
                  ..._getPreventionBasics(contentTitle).map(
                    (prevention) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: AppTextStyles.body),
                          Expanded(
                            child: Text(prevention, style: AppTextStyles.body),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const SectionTitle(title: 'When to Seek Professional Help'),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _getWhenToSeekHelp(contentTitle),
                    style: AppTextStyles.body,
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                Card(
                  color: AppColors.warningOrange.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.warningOrange,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'Educational information only. This content does not replace professional medical advice.',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textPrimaryDarkGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  text: 'Back to Health Education',
                  onPressed: () {
                    Navigator.pop(context);
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

  String _getArticleIntroduction(String title) {
    switch (title) {
      case 'Understanding Balanced Nutrition':
        return 'Balanced nutrition means including a variety of foods and nutrients across meals. This educational overview explains how food groups and portion awareness can support everyday well-being.';
      case 'Understanding Blood Pressure':
        return 'Blood pressure is the force of blood against the walls of arteries as it circulates through the body. Understanding your blood pressure is essential for cardiovascular health.';
      case 'Importance of Regular Exercise':
        return 'Regular physical activity is one of the most important things you can do for your health. It can help control weight, combat health conditions and diseases, and improve mental health.';
      case 'Healthy Sleep Habits':
        return 'Quality sleep is essential for overall health and well-being. Good sleep improves concentration, productivity, and overall quality of life.';
      case 'Staying Hydrated':
        return 'Water is essential for the proper functioning of the body. Staying hydrated supports bodily functions, temperature regulation, and overall health.';
      default:
        return 'This article provides educational information about health and wellness topics.';
    }
  }

  String _getWhyItMatters(String title) {
    switch (title) {
      case 'Understanding Balanced Nutrition':
        return 'Learning about balanced meals can help you make informed food choices that fit your preferences, culture, budget, and health goals.';
      case 'Understanding Blood Pressure':
        return 'High blood pressure can damage arteries, heart, and other organs. Low blood pressure can cause dizziness and fainting. Maintaining healthy blood pressure is crucial for long-term health.';
      case 'Importance of Regular Exercise':
        return 'Exercise helps maintain a healthy weight, strengthens bones and muscles, improves cardiovascular health, and enhances mental well-being by reducing stress and anxiety.';
      case 'Healthy Sleep Habits':
        return 'Poor sleep is linked to numerous health problems including heart disease, diabetes, depression, and accidents. Good sleep enhances learning, memory, and decision-making.';
      case 'Staying Hydrated':
        return 'Proper hydration aids digestion, nutrient absorption, temperature regulation, and cognitive function. Dehydration can lead to fatigue, headaches, and serious health complications.';
      default:
        return 'Understanding health fundamentals helps you make informed decisions about your lifestyle and well-being.';
    }
  }

  List<String> _getHealthyHabits(String title) {
    switch (title) {
      case 'Understanding Balanced Nutrition':
        return [
          'Include a variety of food groups across meals',
          'Pay attention to hunger and fullness cues',
          'Choose water regularly throughout the day',
          'Plan meals around your own needs and preferences',
          'Use reliable sources for nutrition information',
        ];
      case 'Understanding Blood Pressure':
        return [
          'Monitor blood pressure regularly',
          'Maintain a healthy weight',
          'Limit sodium intake',
          'Stay physically active',
          'Manage stress levels',
        ];
      case 'Importance of Regular Exercise':
        return [
          'Aim for 150 minutes of moderate activity per week',
          'Include strength training twice a week',
          'Choose activities you enjoy',
          'Start gradually and increase intensity',
          'Stay consistent with your routine',
        ];
      case 'Healthy Sleep Habits':
        return [
          'Establish a regular sleep schedule',
          'Create a comfortable sleep environment',
          'Limit caffeine and alcohol before bed',
          'Avoid screens before bedtime',
          'Wind down with relaxing activities',
        ];
      case 'Staying Hydrated':
        return [
          'Drink water throughout the day',
          'Eat water-rich foods like fruits and vegetables',
          'Carry a water bottle with you',
          'Monitor urine color as a hydration indicator',
          'Drink more during physical activity',
        ];
      default:
        return [
          'Maintain a balanced lifestyle',
          'Stay informed about health topics',
          'Practice healthy habits daily',
          'Listen to your body',
          'Seek reliable health information',
        ];
    }
  }

  List<String> _getPreventionBasics(String title) {
    switch (title) {
      case 'Understanding Balanced Nutrition':
        return [
          'Avoid relying on a single food or supplement for health',
          'Read nutrition information when it is useful to you',
          'Keep meals varied over time',
          'Ask a qualified professional about personal dietary needs',
          'Be cautious of restrictive or unverified diet claims',
        ];
      case 'Understanding Blood Pressure':
        return [
          'Reduce salt intake in your diet',
          'Maintain a healthy weight',
          'Exercise regularly',
          'Limit alcohol consumption',
          'Manage stress effectively',
        ];
      case 'Importance of Regular Exercise':
        return [
          'Start slowly if you are new to exercise',
          'Use proper form to prevent injury',
          'Stay hydrated during workouts',
          'Include warm-up and cool-down exercises',
          'Listen to your body and rest when needed',
        ];
      case 'Healthy Sleep Habits':
        return [
          'Avoid large meals before bedtime',
          'Exercise regularly but not too close to bedtime',
          'Limit exposure to blue light in the evening',
          'Practice relaxation techniques',
          'Consider white noise for better sleep',
        ];
      case 'Staying Hydrated':
        return [
          'Drink water before you feel thirsty',
          'Adjust water intake based on activity level',
          'Be extra careful in hot weather',
          'Monitor hydration during illness',
          'Choose water over sugary beverages',
        ];
      default:
        return [
          'Consult healthcare professionals for personalized advice',
          'Stay informed about preventive health measures',
          'Follow recommended health guidelines',
          'Maintain regular health checkups',
          'Practice self-care and stress management',
        ];
    }
  }

  String _getWhenToSeekHelp(String title) {
    switch (title) {
      case 'Understanding Balanced Nutrition':
        return 'For personal nutrition concerns, allergies, eating difficulties, or condition-specific dietary needs, consult a qualified healthcare professional or registered dietitian.';
      case 'Understanding Blood Pressure':
        return 'Seek immediate medical attention if you experience severe headache, chest pain, vision problems, or sudden changes in blood pressure readings.';
      case 'Importance of Regular Exercise':
        return 'Consult a healthcare provider before starting a new exercise program, especially if you have pre-existing health conditions or have been inactive for a long time.';
      case 'Healthy Sleep Habits':
        return 'Consider seeing a doctor if you consistently have trouble sleeping, snore loudly, or wake up unrefreshed despite adequate sleep time.';
      case 'Staying Hydrated':
        return 'Seek medical attention if you experience severe dehydration symptoms such as extreme thirst, dark urine, dizziness, or confusion.';
      default:
        return 'For any persistent health concerns or symptoms, consult with qualified healthcare professionals for proper diagnosis and treatment.';
    }
  }
}
