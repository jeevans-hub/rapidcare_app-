import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'healthcare_service_card.dart';

class PopularServicesSection extends StatelessWidget {
  final List<Map<String, dynamic>> services;
  final Function(Map<String, dynamic>)? onServiceTap;

  const PopularServicesSection({
    super.key,
    required this.services,
    this.onServiceTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Container(
            width: 250,
            margin: const EdgeInsets.only(right: AppSpacing.md),
            child: HealthcareServiceCard(
              icon: service['icon'],
              name: service['name'],
              description: service['description'],
              category: service['category'],
              status: service['status'],
              onTap: () => onServiceTap?.call(service),
            ),
          );
        },
      ),
    );
  }
}
