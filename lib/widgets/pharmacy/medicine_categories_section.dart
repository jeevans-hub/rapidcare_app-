import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'medicine_category_card.dart';

class MedicineCategoriesSection extends StatelessWidget {
  final List<String> categories;
  final String? selected;
  final ValueChanged<String?>? onSelected;
  const MedicineCategoriesSection({
    super.key,
    this.categories = const [],
    this.selected,
    this.onSelected,
  });
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 110,
    child: ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      children: [
        for (final category in ['All', ...categories])
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: MedicineCategoryCard(
              icon: Icons.medication,
              name: category,
              isSelected: category == (selected ?? 'All'),
              onTap: () =>
                  onSelected?.call(category == 'All' ? null : category),
            ),
          ),
      ],
    ),
  );
}
