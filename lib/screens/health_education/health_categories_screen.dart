import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_education/health_education_widgets.dart';

class HealthCategoriesScreen extends StatelessWidget {
  HealthCategoriesScreen({super.key});

  final List<Map<String, dynamic>> _categories = [
    {
      'icon': Icons.restaurant,
      'title': 'Nutrition',
      'description': 'Healthy eating and balanced diet',
      'articleCount': 5,
    },
    {
      'icon': Icons.fitness_center,
      'title': 'Exercise',
      'description': 'Physical activity and fitness',
      'articleCount': 4,
    },
    {
      'icon': Icons.bedtime,
      'title': 'Sleep',
      'description': 'Sleep quality and rest',
      'articleCount': 3,
    },
    {
      'icon': Icons.psychology,
      'title': 'Mental Wellness',
      'description': 'Mental health and stress management',
      'articleCount': 4,
    },
    {
      'icon': Icons.favorite,
      'title': 'Heart Health',
      'description': 'Cardiovascular health awareness',
      'articleCount': 3,
    },
    {
      'icon': Icons.vaccines,
      'title': 'Preventive Care',
      'description': 'Preventive health measures',
      'articleCount': 4,
    },
    {
      'icon': Icons.elderly,
      'title': 'Healthy Aging',
      'description': 'Aging gracefully and healthily',
      'articleCount': 3,
    },
    {
      'icon': Icons.medical_services,
      'title': 'First Aid',
      'description': 'Basic first aid awareness',
      'articleCount': 2,
    },
    {
      'icon': Icons.woman,
      'title': 'Women\'s Health',
      'description': 'Women-specific health topics',
      'articleCount': 3,
    },
    {
      'icon': Icons.man,
      'title': 'Men\'s Health',
      'description': 'Men-specific health topics',
      'articleCount': 3,
    },
    {
      'icon': Icons.local_hospital,
      'title': 'General Wellness',
      'description': 'Overall wellness information',
      'articleCount': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Categories'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'All Health Categories',
                  subtitle: 'Browse educational articles by category',
                ),
                const SizedBox(height: AppSpacing.lg),
                HealthArticleCategories(
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
