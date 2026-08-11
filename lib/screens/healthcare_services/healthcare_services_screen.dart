import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import '../../widgets/healthcare_services/healthcare_services_widgets.dart';

class HealthcareServicesScreen extends StatefulWidget {
  const HealthcareServicesScreen({super.key});

  @override
  State<HealthcareServicesScreen> createState() => _HealthcareServicesScreenState();
}

class _HealthcareServicesScreenState extends State<HealthcareServicesScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'Home Care',
    'Laboratory',
    'Checkups',
    'Nursing',
    'Physiotherapy',
    'Elder Care',
    'Wellness',
    'Equipment',
  ];

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

  final List<Map<String, dynamic>> _popularServices = [
    {
      'icon': Icons.health_and_safety,
      'name': 'Home Nursing',
      'description': 'Professional nursing support at home',
      'category': 'Home Care',
      'status': 'Available',
    },
    {
      'icon': Icons.accessibility,
      'name': 'Physiotherapy at Home',
      'description': 'Rehabilitation exercises at home',
      'category': 'Physiotherapy',
      'status': 'Available',
    },
    {
      'icon': Icons.medical_services,
      'name': 'Basic Health Checkup',
      'description': 'Routine health assessment',
      'category': 'Checkups',
      'status': 'Available',
    },
    {
      'icon': Icons.science,
      'name': 'Blood Test',
      'description': 'Complete blood count testing',
      'category': 'Laboratory',
      'status': 'Available',
    },
    {
      'icon': Icons.elderly,
      'name': 'Elder Care',
      'description': 'Specialized care for seniors',
      'category': 'Elder Care',
      'status': 'Available',
    },
  ];

  List<Map<String, dynamic>> _getFilteredServices() {
    if (_selectedFilter == 'All') return _popularServices;
    return _popularServices.where((service) {
      return service['category'] == _selectedFilter ||
             (_selectedFilter == 'Home Care' && service['category'] == 'Home Care') ||
             (_selectedFilter == 'Laboratory' && service['category'] == 'Laboratory') ||
             (_selectedFilter == 'Checkups' && service['category'] == 'Checkups') ||
             (_selectedFilter == 'Nursing' && service['category'] == 'Home Care') ||
             (_selectedFilter == 'Physiotherapy' && service['category'] == 'Physiotherapy') ||
             (_selectedFilter == 'Elder Care' && service['category'] == 'Elder Care') ||
             (_selectedFilter == 'Wellness' && service['category'] == 'Checkups') ||
             (_selectedFilter == 'Equipment' && service['category'] == 'Home Care');
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredServices = _getFilteredServices();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthcare Services'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HealthcareServicesHeader(),
                const SizedBox(height: AppSpacing.lg),
                HealthcareServiceSearch(
                  hintText: 'Search healthcare services...',
                  onChanged: (value) {
                    // Search functionality can be implemented later
                  },
                  onClear: () {
                    // Clear functionality can be implemented later
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                HealthcareServiceFilters(
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
                  title: 'Service Categories',
                ),
                const SizedBox(height: AppSpacing.md),
                HealthcareServiceCategories(
                  categories: _categories,
                  onCategoryTap: (category) {
                    setState(() {
                      _selectedFilter = category;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(
                  title: 'Popular Services',
                ),
                const SizedBox(height: AppSpacing.md),
                PopularServicesSection(
                  services: filteredServices,
                  onServiceTap: (service) {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.healthcareServiceDetails,
                      arguments: service,
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionTitle(
                  title: 'Home Healthcare',
                ),
                const SizedBox(height: AppSpacing.md),
                const HomeHealthcareCard(),
                const SizedBox(height: AppSpacing.lg),
                const SectionTitle(
                  title: 'Laboratory Services',
                ),
                const SizedBox(height: AppSpacing.md),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.laboratoryServices);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          const Icon(Icons.science, size: 40),
                          const SizedBox(width: AppSpacing.md),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Laboratory Services'),
                                SizedBox(height: 4),
                                Text('Diagnostic testing and lab work'),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionTitle(
                  title: 'Health Packages',
                ),
                const SizedBox(height: AppSpacing.md),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthPackages);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          const Icon(Icons.medical_services, size: 40),
                          const SizedBox(width: AppSpacing.md),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Health Checkup Packages'),
                                SizedBox(height: 4),
                                Text('Comprehensive health assessment packages'),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
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
