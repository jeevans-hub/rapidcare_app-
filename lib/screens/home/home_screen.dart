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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: AppSpacing.lg),
              DashboardHeader(),
              SizedBox(height: AppSpacing.lg),
              SearchBarWidget(),
              SizedBox(height: AppSpacing.lg),
              QuickActionsGrid(),
              SizedBox(height: AppSpacing.xl),
              AppointmentCard(),
              SizedBox(height: AppSpacing.xl),
              HealthStatisticsSection(),
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
