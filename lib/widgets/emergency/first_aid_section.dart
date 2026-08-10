import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import 'first_aid_tip_card.dart';

class FirstAidSection extends StatelessWidget {
  const FirstAidSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'First Aid Tips',
          subtitle: 'Quick medical guidance for emergencies',
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              FirstAidTipCard(
                icon: Icons.favorite,
                title: 'Heart Attack',
                description: 'Recognize symptoms and provide immediate assistance',
              ),
              SizedBox(width: AppSpacing.sm),
              FirstAidTipCard(
                icon: Icons.local_fire_department,
                title: 'Burn Injury',
                description: 'Proper treatment for burns and scalds',
              ),
              SizedBox(width: AppSpacing.sm),
              FirstAidTipCard(
                icon: Icons.accessibility,
                title: 'Fracture',
                description: 'Handle broken bones safely',
              ),
              SizedBox(width: AppSpacing.sm),
              FirstAidTipCard(
                icon: Icons.water_drop,
                title: 'Bleeding',
                description: 'Control bleeding effectively',
              ),
              SizedBox(width: AppSpacing.sm),
              FirstAidTipCard(
                icon: Icons.pets,
                title: 'Snake Bite',
                description: 'First aid for snake bites',
              ),
              SizedBox(width: AppSpacing.sm),
              FirstAidTipCard(
                icon: Icons.health_and_safety,
                title: 'CPR',
                description: 'Cardiopulmonary resuscitation steps',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
