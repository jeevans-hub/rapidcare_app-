import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_insurance/health_insurance_widgets.dart';

class InsuranceCategoriesScreen extends StatelessWidget {
  InsuranceCategoriesScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance Categories'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'All Insurance Categories',
                  subtitle: 'Browse insurance plans by category',
                ),
                const SizedBox(height: AppSpacing.lg),
                InsuranceCategories(
                  categories: _categories,
                  onCategoryTap: (category) {
                    Navigator.pop(context);
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
}
