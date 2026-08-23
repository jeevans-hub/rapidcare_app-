import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import '../../widgets/profile/profile_widgets.dart';
import '../../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await AuthService.getCurrentUser();

    setState(() {
      _isLoading = false;
    });

    if (result['success'] == true) {
      setState(() {
        _userData = result['data']['user'];
      });
    } else {
      // If not authenticated or error, use demo data
      setState(() {
        _errorMessage = result['message'];
        _userData = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _userData?['name'] ?? '';
    final displayEmail = _userData?['email'] ?? '';
    final displayPhone = _userData?['phone'] ?? '';
    final displayDateOfBirth = _userData?['dateOfBirth'] != null
        ? DateTime.parse(_userData!['dateOfBirth']).toString().split(' ')[0]
        : '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.xl),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      Icon(Icons.error_outline, size: 48, color: Colors.grey),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Unable to load profile information',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ElevatedButton(
                        onPressed: _loadUserProfile,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              else if (_userData == null)
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      Icon(Icons.person_outline, size: 48, color: Colors.grey),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Please log in to view your profile',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, AppRoutes.login);
                        },
                        child: const Text('Go to Login'),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: [
                    ProfileHeader(
                      name: displayName.isNotEmpty ? displayName : 'User',
                      email: displayEmail.isNotEmpty ? displayEmail : 'user@example.com',
                      onEditTap: () {
                        Navigator.pushNamed(context, AppRoutes.editProfile).then((_) {
                          // Refresh profile after editing
                          _loadUserProfile();
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: ProfileStatisticsCard(
                        appointments: 12,
                        prescriptions: 5,
                        healthRecords: 8,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: SectionTitle(title: 'Personal Information'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: Column(
                        children: [
                          ProfileInfoCard(
                            icon: Icons.person,
                            label: 'Full Name',
                            value: displayName.isNotEmpty ? displayName : 'Not set',
                          ),
                          SizedBox(height: AppSpacing.sm),
                          ProfileInfoCard(
                            icon: Icons.email,
                            label: 'Email',
                            value: displayEmail.isNotEmpty ? displayEmail : 'Not set',
                          ),
                          SizedBox(height: AppSpacing.sm),
                          ProfileInfoCard(
                            icon: Icons.phone,
                            label: 'Phone',
                            value: displayPhone.isNotEmpty ? displayPhone : 'Not set',
                          ),
                          SizedBox(height: AppSpacing.sm),
                          ProfileInfoCard(
                            icon: Icons.cake,
                            label: 'Date of Birth',
                            value: displayDateOfBirth.isNotEmpty ? displayDateOfBirth : 'Not set',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: SectionTitle(title: 'Medical Information'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: Column(
                        children: [
                          MedicalInfoCard(
                            icon: Icons.bloodtype,
                            label: 'Blood Group',
                            value: 'O+',
                          ),
                          SizedBox(height: AppSpacing.sm),
                          MedicalInfoCard(
                            icon: Icons.height,
                            label: 'Height',
                            value: '175 cm',
                          ),
                          SizedBox(height: AppSpacing.sm),
                          MedicalInfoCard(
                            icon: Icons.monitor_weight,
                            label: 'Weight',
                            value: '70 kg',
                          ),
                          SizedBox(height: AppSpacing.sm),
                          MedicalInfoCard(
                            icon: Icons.contact_phone,
                            label: 'Emergency Contact',
                            value: 'Jane Doe (Spouse)',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: SectionTitle(title: 'Menu'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: Column(
                        children: [
                          ProfileMenuItem(
                            icon: Icons.calendar_today,
                            title: 'My Appointments',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.appointments);
                            },
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ProfileMenuItem(
                            icon: Icons.medication,
                            title: 'Pharmacy Orders',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.pharmacyHome);
                            },
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ProfileMenuItem(
                            icon: Icons.folder_open,
                            title: 'Medical Records',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.medicalRecords);
                            },
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ProfileMenuItem(
                            icon: Icons.local_hospital,
                            title: 'Healthcare Services',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.healthcareServices);
                            },
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ProfileMenuItem(
                            icon: Icons.shield,
                            title: 'Health Insurance',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.healthInsurance);
                            },
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ProfileMenuItem(
                            icon: Icons.school,
                            title: 'Health Education',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.healthEducation);
                            },
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ProfileMenuItem(
                            icon: Icons.monitor_heart,
                            title: 'Health Monitoring',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.healthMonitoring);
                            },
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ProfileMenuItem(
                            icon: Icons.assessment,
                            title: 'Health Reports',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.healthReports);
                            },
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ProfileMenuItem(
                            icon: Icons.contacts,
                            title: 'Emergency Contacts',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.emergencyContacts);
                            },
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ProfileMenuItem(
                            icon: Icons.settings,
                            title: 'Settings',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.settings);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
