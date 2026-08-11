import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import '../../widgets/healthcare_services/healthcare_services_widgets.dart';

class HealthcareServiceCategoriesScreen extends StatelessWidget {
  HealthcareServiceCategoriesScreen({super.key});

  final List<Map<String, dynamic>> _categories = [
    {
      'icon': Icons.home,
      'title': 'Home Healthcare',
      'description': 'Care services at home',
      'serviceCount': 5,
    },
    {
      'icon': Icons.science,
      'title': 'Laboratory',
      'description': 'Diagnostic testing services',
      'serviceCount': 7,
    },
    {
      'icon': Icons.medical_services,
      'title': 'Health Checkups',
      'description': 'Comprehensive health packages',
      'serviceCount': 5,
    },
    {
      'icon': Icons.health_and_safety,
      'title': 'Nursing Care',
      'description': 'Professional nursing support',
      'serviceCount': 3,
    },
    {
      'icon': Icons.accessibility,
      'title': 'Physiotherapy',
      'description': 'Rehabilitation services',
      'serviceCount': 2,
    },
    {
      'icon': Icons.elderly,
      'title': 'Elder Care',
      'description': 'Specialized senior care',
      'serviceCount': 2,
    },
    {
      'icon': Icons.spa,
      'title': 'Wellness Services',
      'description': 'Health and wellness programs',
      'serviceCount': 3,
    },
    {
      'icon': Icons.devices,
      'title': 'Medical Equipment',
      'description': 'Home medical supplies',
      'serviceCount': 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Categories'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'All Service Categories',
                  subtitle: 'Browse healthcare services by category',
                ),
                const SizedBox(height: AppSpacing.lg),
                HealthcareServiceCategories(
                  categories: _categories,
                  onCategoryTap: (category) {
                    _navigateToCategory(context, category);
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToCategory(BuildContext context, String category) {
    switch (category) {
      case 'Home Healthcare':
        Navigator.pushNamed(context, AppRoutes.homeHealthcare);
        break;
      case 'Laboratory':
        Navigator.pushNamed(context, AppRoutes.laboratoryServices);
        break;
      case 'Health Checkups':
        Navigator.pushNamed(context, AppRoutes.healthPackages);
        break;
      default:
        Navigator.pop(context);
        break;
    }
  }
}
