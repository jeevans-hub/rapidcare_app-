import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_education/health_education_widgets.dart';

class HealthEducationScreen extends StatefulWidget {
  const HealthEducationScreen({super.key});

  @override
  State<HealthEducationScreen> createState() => _HealthEducationScreenState();
}

class _HealthEducationScreenState extends State<HealthEducationScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'Nutrition',
    'Exercise',
    'Sleep',
    'Mental Wellness',
    'Heart Health',
    'Preventive Care',
    'Healthy Aging',
    'First Aid',
    'General Wellness',
  ];

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
  ];

  final List<Map<String, dynamic>> _articles = [
    {
      'title': 'Understanding Blood Pressure',
      'category': 'Heart Health',
      'description': 'Learn about blood pressure management and monitoring',
      'readingTime': '5 min read',
      'icon': Icons.favorite,
    },
    {
      'title': 'Importance of Regular Exercise',
      'category': 'Exercise',
      'description': 'Benefits of staying physically active for overall health',
      'readingTime': '4 min read',
      'icon': Icons.fitness_center,
    },
    {
      'title': 'Healthy Sleep Habits',
      'category': 'Sleep',
      'description': 'Tips for better sleep quality and rest routines',
      'readingTime': '6 min read',
      'icon': Icons.bedtime,
    },
    {
      'title': 'Staying Hydrated',
      'category': 'Nutrition',
      'description': 'Why hydration matters and how to stay properly hydrated',
      'readingTime': '3 min read',
      'icon': Icons.water_drop,
    },
  ];

  List<Map<String, dynamic>> _getFilteredArticles() {
    if (_selectedFilter == 'All') return _articles;
    return _articles.where((article) {
      return article['category'] == _selectedFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredArticles = _getFilteredArticles();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Education'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HealthEducationHeader(),
                const SizedBox(height: AppSpacing.lg),
                HealthArticleSearch(
                  hintText: 'Search health articles...',
                  onChanged: (value) {
                    // Search functionality
                  },
                  onClear: () {
                    // Clear functionality
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                HealthArticleFilters(
                  filters: _filters,
                  selectedFilter: _selectedFilter,
                  onFilterChanged: (filter) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionTitle(title: 'Article Categories'),
                const SizedBox(height: AppSpacing.md),
                HealthArticleCategories(
                  categories: _categories,
                  onCategoryTap: (category) {
                    setState(() {
                      _selectedFilter = category;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(title: 'Featured Article'),
                const SizedBox(height: AppSpacing.md),
                FeaturedHealthArticle(
                  title: 'Understanding Balanced Nutrition',
                  description: 'Learn about the importance of a balanced diet, portion control, and how different food groups contribute to your overall health and well-being.',
                  category: 'Nutrition',
                  readingTime: '8 min read',
                  icon: Icons.restaurant,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.healthArticleDetails,
                      arguments: _articles[3],
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(title: 'Latest Articles'),
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
                      itemCount: filteredArticles.length,
                      itemBuilder: (context, index) {
                        final article = filteredArticles[index];
                        return HealthArticleCard(
                          title: article['title'],
                          category: article['category'],
                          description: article['description'],
                          readingTime: article['readingTime'],
                          icon: article['icon'],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.healthArticleDetails,
                              arguments: article,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(title: 'Quick Access'),
                const SizedBox(height: AppSpacing.md),
                ListTile(
                  leading: const Icon(Icons.fitness_center),
                  title: const Text('Health Tips'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthTips);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.healing),
                  title: const Text('First Aid'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthFirstAid);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Health FAQ'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthFaq);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.monitor_heart),
                  title: const Text('Health Monitoring'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthMonitoring);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.library_books),
                  title: const Text('Wellness Resources'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.wellnessResources);
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
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
                            'Educational information only. This content does not replace professional medical advice.',
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
