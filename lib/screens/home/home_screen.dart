import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/dashboard/dashboard_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.appointments);
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.emergencyHome);
        break;
      case 3:
        Navigator.pushNamed(context, AppRoutes.pharmacyHome);
        break;
      case 4:
        Navigator.pushNamed(context, AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSpacing.lg),
              DashboardHeader(),
              SizedBox(height: AppSpacing.lg),
              DashboardWelcomeCard(),
              SizedBox(height: AppSpacing.lg),
              QuickActionsGrid(),
              SizedBox(height: AppSpacing.xl),
              DashboardHealthOverview(),
              SizedBox(height: AppSpacing.xl),
              DashboardAppointmentPreview(),
              SizedBox(height: AppSpacing.md),
              LayoutBuilder(
                builder: (context, constraints) {
                  final textScale =
                      MediaQuery.textScalerOf(context).scale(16) / 16;
                  if (constraints.maxWidth < 720 * textScale) {
                    return const Column(
                      children: [
                        DashboardHealthMonitoringPreview(),
                        SizedBox(height: AppSpacing.md),
                        DashboardHealthReportsPreview(),
                      ],
                    );
                  }
                  return const Row(
                    children: [
                      Expanded(child: DashboardHealthMonitoringPreview()),
                      SizedBox(width: AppSpacing.md),
                      Expanded(child: DashboardHealthReportsPreview()),
                    ],
                  );
                },
              ),
              SizedBox(height: AppSpacing.xl),
              DashboardServicesPreview(),
              SizedBox(height: AppSpacing.xl),
              HealthTipsSection(),
              SizedBox(height: AppSpacing.xl),
              NearbyHospitalSection(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.errorRed,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.emergencyHome);
        },
        child: const Icon(Icons.emergency, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}
