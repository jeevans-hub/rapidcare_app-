import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_education/health_education_widgets.dart';

class HealthFirstAidScreen extends StatelessWidget {
  HealthFirstAidScreen({super.key});

  final List<Map<String, dynamic>> _firstAidTopics = [
    {
      'topic': 'Minor Cuts',
      'description': 'Basic care for minor cuts and scrapes including cleaning and bandaging.',
      'isEmergency': false,
    },
    {
      'topic': 'Minor Burns',
      'description': 'First aid for minor burns including cooling and protecting the area.',
      'isEmergency': false,
    },
    {
      'topic': 'Nosebleeds',
      'description': 'Basic guidance for managing common nosebleeds.',
      'isEmergency': false,
    },
    {
      'topic': 'Sprains',
      'description': 'Initial care for sprains using R.I.C.E. method awareness.',
      'isEmergency': false,
    },
    {
      'topic': 'Fainting',
      'description': 'Basic awareness for when someone faints and how to respond.',
      'isEmergency': true,
    },
    {
      'topic': 'Basic CPR Awareness',
      'description': 'Awareness of CPR as an emergency technique. Seek professional training.',
      'isEmergency': true,
    },
    {
      'topic': 'Choking Awareness',
      'description': 'Awareness of choking signs and emergency response guidance.',
      'isEmergency': true,
    },
    {
      'topic': 'Heat-Related Illness Awareness',
      'description': 'Awareness of heat exhaustion and heat stroke signs.',
      'isEmergency': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Aid'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'First Aid Awareness',
                  subtitle: 'Educational information only',
                ),
                const SizedBox(height: AppSpacing.lg),
                Card(
                  color: AppColors.errorRed.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: AppColors.errorRed),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'This is educational information only. For emergencies, contact emergency medical services immediately.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionTitle(title: 'Common First Aid Topics'),
                const SizedBox(height: AppSpacing.md),
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
                      itemCount: _firstAidTopics.length,
                      itemBuilder: (context, index) {
                        final topic = _firstAidTopics[index];
                        return FirstAidCard(
                          topic: topic['topic'],
                          description: topic['description'],
                          isEmergency: topic['isEmergency'],
                          onTap: () => _showTopicDetails(context, topic['topic'] as String),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(title: 'Emergency Assistance'),
                const SizedBox(height: AppSpacing.md),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.large),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.emergency,
                              size: 48,
                              color: AppColors.errorRed,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Need Emergency Help?',
                                    style: AppTextStyles.title,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    'Access the Emergency Assistance module for emergency contacts and support.',
                                    style: AppTextStyles.caption,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        PrimaryButton(
                          text: 'Go to Emergency Assistance',
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.emergencyHome);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
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
                            'For serious emergencies, call emergency services immediately. This module provides educational awareness only.',
                            style: AppTextStyles.caption,
                          ),
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
      ),
    );
  }

  void _showTopicDetails(BuildContext context, String topic) {
    const details = <String, String>{
      'Minor Cuts': 'Wash your hands, apply gentle pressure with clean gauze to minor bleeding, rinse the area with clean running water, and cover it with a clean dressing. Seek professional care for deep, heavily bleeding, contaminated, or worsening wounds.',
      'Minor Burns': 'Cool a minor burn with clean, cool running water and protect it with a clean, non-stick covering. Do not use ice, butter, or unverified substances. Seek urgent care for extensive, deep, electrical, chemical, or facial burns.',
      'Nosebleeds': 'Sit upright, lean slightly forward, and pinch the soft part of the nose continuously for several minutes. Do not tilt the head backward. Seek urgent care if bleeding is severe, follows an injury, or does not stop.',
      'Sprains': 'Protect the area from further injury and rest it. A wrapped cold pack may help with swelling, and gentle elevation can be comfortable. Seek professional assessment for severe pain, deformity, numbness, or inability to use the limb.',
      'Fainting': 'Help the person lie down safely and check responsiveness and breathing. Call emergency services if they do not quickly recover, are injured, have breathing problems, or the fainting may be related to a serious condition. Do not give food or drink to an unconscious person.',
      'Basic CPR Awareness': 'If an adult is unresponsive and not breathing normally, call emergency services and follow the dispatcher instructions. Use an AED if available and trained to do so. This screen is awareness information and does not replace certified CPR training.',
      'Choking Awareness': 'If a person cannot breathe, speak, or cough effectively, call emergency services and follow the dispatcher instructions. If they can cough forcefully, encourage coughing. Do not put fingers into the mouth unless an object is clearly visible.',
      'Heat-Related Illness Awareness': 'Move the person to a cooler place and seek professional help for confusion, fainting, seizures, or worsening symptoms. Do not delay emergency care for suspected heat stroke. This information does not replace medical assessment.',
    };
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(topic),
        content: SingleChildScrollView(child: Text(details[topic] ?? 'Detailed information is not available for this topic.')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Close')),
        ],
      ),
    );
  }
}
