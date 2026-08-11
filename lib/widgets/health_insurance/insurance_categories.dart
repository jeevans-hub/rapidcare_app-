import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'insurance_category_card.dart';

class InsuranceCategories extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final Function(String)? onCategoryTap;

  const InsuranceCategories({
    super.key,
    required this.categories,
    this.onCategoryTap,
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
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return InsuranceCategoryCard(
              icon: category['icon'],
              title: category['title'],
              description: category['description'],
              planCount: category['planCount'],
              onTap: () => onCategoryTap?.call(category['title']),
            );
          },
        );
      },
    );
  }
}
