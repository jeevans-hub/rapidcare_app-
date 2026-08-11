import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import '../../widgets/healthcare_services/healthcare_services_widgets.dart';

class HomeHealthcareScreen extends StatelessWidget {
  HomeHealthcareScreen({super.key});

  final List<Map<String, dynamic>> _services = [
    {
      'icon': Icons.health_and_safety,
      'name': 'Home Nursing',
      'description': 'Professional nursing support at home',
      'category': 'Home Care',
      'status': 'Available',
    },
    {
      'icon': Icons.elderly,
      'name': 'Elder Care Assistance',
      'description': 'Specialized care for elderly individuals',
      'category': 'Home Care',
      'status': 'Available',
    },
    {
      'icon': Icons.home,
      'name': 'Home Care Support',
      'description': 'General assistance with daily activities',
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
      'icon': Icons.healing,
      'name': 'General Care Assistance',
      'description': 'Comprehensive home care services',
      'category': 'Home Care',
      'status': 'Available',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Healthcare'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Home Healthcare',
                  subtitle: 'Care services available in a home setting',
                ),
                const SizedBox(height: AppSpacing.lg),
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
                      itemCount: _services.length,
                      itemBuilder: (context, index) {
                        final service = _services[index];
                        return HealthcareServiceCard(
                          icon: service['icon'],
                          name: service['name'],
                          description: service['description'],
                          category: service['category'],
                          status: service['status'],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.healthcareServiceDetails,
                              arguments: service,
                            );
                          },
                        );
                      },
                    );
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
