import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/primary_button.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              const Text(
                'Manage Your Appointments',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Book appointments with doctors and manage your schedule.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                text: 'Find Doctors',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.doctorList);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                text: 'View Appointment History',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.doctorList);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
