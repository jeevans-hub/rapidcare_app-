import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import 'medicine_category_card.dart';

class MedicineCategoriesSection extends StatelessWidget {
  const MedicineCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: SectionTitle(
            title: 'Categories',
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            children: const [
              MedicineCategoryCard(
                icon: Icons.medication,
                name: 'Medicine',
                isSelected: true,
              ),
              SizedBox(width: AppSpacing.md),
              MedicineCategoryCard(
                icon: Icons.vaccines,
                name: 'Vitamins',
              ),
              SizedBox(width: AppSpacing.md),
              MedicineCategoryCard(
                icon: Icons.person,
                name: 'Personal Care',
              ),
              SizedBox(width: AppSpacing.md),
              MedicineCategoryCard(
                icon: Icons.medical_services,
                name: 'First Aid',
              ),
              SizedBox(width: AppSpacing.md),
              MedicineCategoryCard(
                icon: Icons.child_care,
                name: 'Baby Care',
              ),
              SizedBox(width: AppSpacing.md),
              MedicineCategoryCard(
                icon: Icons.monitor_heart,
                name: 'Health Devices',
              ),
              SizedBox(width: AppSpacing.md),
            ],
          ),
        ),
      ],
    );
  }
}
