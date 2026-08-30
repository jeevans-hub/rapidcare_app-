import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
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
            children: [
              FirstAidTipCard(
                icon: Icons.favorite,
                title: 'Heart Attack',
                description: 'Recognize symptoms and provide immediate assistance',
                onTap: () => Navigator.pushNamed(context, AppRoutes.firstAid, arguments: {'topic': 'Heart Attack'}),
              ),
              SizedBox(width: AppSpacing.sm),
              FirstAidTipCard(
                icon: Icons.local_fire_department,
                title: 'Burn Injury',
                description: 'Proper treatment for burns and scalds',
                onTap: () => Navigator.pushNamed(context, AppRoutes.firstAid, arguments: {'topic': 'Burns'}),
              ),
              SizedBox(width: AppSpacing.sm),
              FirstAidTipCard(
                icon: Icons.accessibility,
                title: 'Fracture',
                description: 'Handle broken bones safely',
                onTap: () => Navigator.pushNamed(context, AppRoutes.firstAid, arguments: {'topic': 'Fractures'}),
              ),
              SizedBox(width: AppSpacing.sm),
              FirstAidTipCard(
                icon: Icons.water_drop,
                title: 'Bleeding',
                description: 'Control bleeding effectively',
                onTap: () => Navigator.pushNamed(context, AppRoutes.firstAid, arguments: {'topic': 'Bleeding'}),
              ),
              SizedBox(width: AppSpacing.sm),
              FirstAidTipCard(
                icon: Icons.pets,
                title: 'Snake Bite',
                description: 'First aid for snake bites',
                onTap: () => Navigator.pushNamed(context, AppRoutes.firstAid, arguments: {'topic': 'Snake Bite'}),
              ),
              SizedBox(width: AppSpacing.sm),
              FirstAidTipCard(
                icon: Icons.health_and_safety,
                title: 'CPR',
                description: 'Cardiopulmonary resuscitation steps',
                onTap: () => Navigator.pushNamed(context, AppRoutes.firstAid, arguments: {'topic': 'CPR'}),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
