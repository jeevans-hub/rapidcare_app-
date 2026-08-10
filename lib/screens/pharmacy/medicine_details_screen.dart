import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';
import '../../widgets/pharmacy/pharmacy_widgets.dart';

class MedicineDetailsScreen extends StatelessWidget {
  const MedicineDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.backgroundLightGrey,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(AppRadius.large),
                    bottomRight: Radius.circular(AppRadius.large),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.medication,
                    size: 100,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Paracetamol 500mg',
                            style: AppTextStyles.headline.copyWith(fontSize: 24),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.errorRed,
                            borderRadius: BorderRadius.circular(AppRadius.small),
                          ),
                          child: const Text(
                            '25% OFF',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Pain Relief',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondaryGrey,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 20,
                          color: AppColors.warningOrange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '4.5',
                          style: AppTextStyles.body,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          '(128 reviews)',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        Text(
                          '\$5.99',
                          style: AppTextStyles.headline.copyWith(
                            color: AppColors.primaryBlue,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          '\$7.99',
                          style: AppTextStyles.title.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.textSecondaryGrey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const SectionTitle(title: 'Description'),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Paracetamol 500mg is a pain reliever and a fever reducer. It is used to treat many conditions such as headache, muscle aches, arthritis, backache, toothaches, colds, and fevers.',
                      style: AppTextStyles.body,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const SectionTitle(title: 'Benefits'),
                    const SizedBox(height: AppSpacing.sm),
                    _BenefitItem(text: 'Relieves pain and fever'),
                    _BenefitItem(text: 'Fast-acting formula'),
                    _BenefitItem(text: 'Easy to swallow'),
                    const SizedBox(height: AppSpacing.lg),
                    const SectionTitle(title: 'Usage'),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Take 1 tablet every 4-6 hours as needed. Do not exceed 4 tablets in 24 hours.',
                      style: AppTextStyles.body,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const SectionTitle(title: 'Quantity'),
                    const SizedBox(height: AppSpacing.sm),
                    const MedicineQuantitySelector(),
                    const SizedBox(height: AppSpacing.xl),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.pharmacyCart);
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppRadius.medium),
                              ),
                            ),
                            child: const Text('Add to Cart'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Buy Now',
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.pharmacyCart);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final String text;

  const _BenefitItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            size: 20,
            color: AppColors.successGreen,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            text,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}
