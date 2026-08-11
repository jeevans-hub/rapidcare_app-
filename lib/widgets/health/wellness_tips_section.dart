import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import 'wellness_tip_card.dart';

class WellnessTipsSection extends StatelessWidget {
  final List<TipItem> tips;

  const WellnessTipsSection({
    super.key,
    required this.tips,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Wellness Tips'),
        const SizedBox(height: AppSpacing.md),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            children: tips.map((tip) {
              return Padding(
                padding: const EdgeInsets.only(right: AppSpacing.md),
                child: WellnessTipCard(
                  icon: tip.icon,
                  title: tip.title,
                  description: tip.description,
                  onReadMore: tip.onReadMore,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class TipItem {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onReadMore;

  TipItem({
    required this.icon,
    required this.title,
    required this.description,
    this.onReadMore,
  });
}
