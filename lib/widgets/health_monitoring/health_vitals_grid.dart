import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'health_vital_card.dart';

class HealthVitalsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> vitals;
  final Function(String)? onVitalTap;

  const HealthVitalsGrid({
    super.key,
    required this.vitals,
    this.onVitalTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.0,
          ),
          itemCount: vitals.length,
          itemBuilder: (context, index) {
            final vital = vitals[index];
            return HealthVitalCard(
              vitalName: vital['vitalName'],
              value: vital['value'],
              unit: vital['unit'],
              icon: vital['icon'],
              onTap: () => onVitalTap?.call(vital['vitalName']),
            );
          },
        );
      },
    );
  }
}
