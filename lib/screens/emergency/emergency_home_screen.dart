import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/emergency/emergency_widgets.dart';

class EmergencyHomeScreen extends StatelessWidget {
  const EmergencyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Assistance'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const EmergencyHeader(),
              const SizedBox(height: AppSpacing.lg),
              Center(
                child: const SOSButton(),
              ),
              const SizedBox(height: AppSpacing.xl),
              const EmergencyServicesGrid(),
              const SizedBox(height: AppSpacing.xl),
              const AmbulanceTrackerCard(),
              const SizedBox(height: AppSpacing.lg),
              const NearbyHospitalsSection(),
              const SizedBox(height: AppSpacing.xl),
              const EmergencyContactsSection(),
              const SizedBox(height: AppSpacing.xl),
              const FirstAidSection(),
              const SizedBox(height: AppSpacing.xl),
              _buildQuickActions(context),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.ambulanceRequest);
                },
                icon: const Icon(Icons.local_taxi),
                label: const Text('Request Ambulance'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.emergencyContacts);
                },
                icon: const Icon(Icons.contacts),
                label: const Text('Contacts'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.firstAid);
            },
            icon: const Icon(Icons.medical_services),
            label: const Text('First Aid Guide'),
          ),
        ),
      ],
    );
  }
}
