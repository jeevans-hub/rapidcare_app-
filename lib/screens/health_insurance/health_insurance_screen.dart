import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_insurance/health_insurance_widgets.dart';

class HealthInsuranceScreen extends StatefulWidget {
  const HealthInsuranceScreen({super.key});

  @override
  State<HealthInsuranceScreen> createState() => _HealthInsuranceScreenState();
}

class _HealthInsuranceScreenState extends State<HealthInsuranceScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'Individual',
    'Family',
    'Senior',
    'Critical Illness',
    'Hospitalization',
    'Maternity',
    'Accident',
  ];

  final List<Map<String, dynamic>> _categories = [
    {
      'icon': Icons.person,
      'title': 'Individual Health Insurance',
      'description': 'Coverage for individuals',
      'planCount': 3,
    },
    {
      'icon': Icons.family_restroom,
      'title': 'Family Health Insurance',
      'description': 'Family coverage plans',
      'planCount': 2,
    },
    {
      'icon': Icons.elderly,
      'title': 'Senior Citizen Insurance',
      'description': 'Specialized senior plans',
      'planCount': 2,
    },
    {
      'icon': Icons.healing,
      'title': 'Critical Illness',
      'description': 'Critical illness coverage',
      'planCount': 2,
    },
    {
      'icon': Icons.local_hospital,
      'title': 'Hospitalization Cover',
      'description': 'Hospitalization expenses',
      'planCount': 3,
    },
    {
      'icon': Icons.child_care,
      'title': 'Maternity Cover',
      'description': 'Maternity benefits',
      'planCount': 1,
    },
    {
      'icon': Icons.directions_car,
      'title': 'Accident Cover',
      'description': 'Accident protection',
      'planCount': 2,
    },
    {
      'icon': Icons.health_and_safety,
      'title': 'Preventive Health Cover',
      'description': 'Preventive care',
      'planCount': 1,
    },
  ];

  final List<Map<String, dynamic>> _popularPlans = [
    {
      'planName': 'Basic Health Cover',
      'description': 'Essential health coverage for individuals',
      'coverageAmount': '₹5,00,000',
      'premium': '₹2,500/year',
      'category': 'Individual',
    },
    {
      'planName': 'Comprehensive Health Cover',
      'description': 'Complete health protection with extensive benefits',
      'coverageAmount': '₹10,00,000',
      'premium': '₹5,000/year',
      'category': 'Individual',
    },
    {
      'planName': 'Family Health Plan',
      'description': 'Comprehensive coverage for the entire family',
      'coverageAmount': '₹15,00,000',
      'premium': '₹8,000/year',
      'category': 'Family',
    },
    {
      'planName': 'Senior Citizen Health Plan',
      'description': 'Specialized coverage for seniors with age-related benefits',
      'coverageAmount': '₹8,00,000',
      'premium': '₹6,500/year',
      'category': 'Senior',
    },
    {
      'planName': 'Critical Care Protection',
      'description': 'Focused coverage for critical illnesses',
      'coverageAmount': '₹20,00,000',
      'premium': '₹4,000/year',
      'category': 'Critical Illness',
    },
  ];

  List<Map<String, dynamic>> _getFilteredPlans() {
    if (_selectedFilter == 'All') return _popularPlans;
    return _popularPlans.where((plan) {
      return plan['category'] == _selectedFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPlans = _getFilteredPlans();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Insurance'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HealthInsuranceHeader(),
                const SizedBox(height: AppSpacing.lg),
                InsuranceSearch(
                  hintText: 'Search insurance plans...',
                  onChanged: (value) {
                    // Search functionality can be implemented later
                  },
                  onClear: () {
                    // Clear functionality can be implemented later
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                InsuranceFilters(
                  filters: _filters,
                  selectedFilter: _selectedFilter,
                  onFilterChanged: (filter) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionTitle(
                  title: 'Insurance Categories',
                ),
                const SizedBox(height: AppSpacing.md),
                InsuranceCategories(
                  categories: _categories,
                  onCategoryTap: (category) {
                    setState(() {
                      _selectedFilter = category;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(
                  title: 'Popular Insurance Plans',
                ),
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
                      itemCount: filteredPlans.length,
                      itemBuilder: (context, index) {
                        final plan = filteredPlans[index];
                        return InsurancePlanCard(
                          planName: plan['planName'],
                          description: plan['description'],
                          coverageAmount: plan['coverageAmount'],
                          premium: plan['premium'],
                          category: plan['category'],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.insurancePlanDetails,
                              arguments: plan,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(
                  title: 'Benefits Information',
                ),
                const SizedBox(height: AppSpacing.md),
                InsuranceBenefitsCard(
                  title: 'Key Benefits',
                  benefits: [
                    'Cashless hospitalization',
                    'Pre and post hospitalization coverage',
                    'Day care procedures covered',
                    'No claim bonus benefits',
                    'Tax benefits under Section 80D',
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
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
                            'All premium amounts and coverage details are demo/illustrative values only. No actual policy purchase is available.',
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
}
