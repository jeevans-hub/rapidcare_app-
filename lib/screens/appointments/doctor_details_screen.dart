import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';
import '../../widgets/appointments/doctor_rating_widget.dart';
import '../../widgets/doctors/doctor_widgets.dart';
import '../../services/doctor_service.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({super.key});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  Map<String, dynamic>? doctor;
  bool isLoading = true;
  String? errorMessage;
  String? doctorId;
  bool _argumentsRead = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_argumentsRead) return;
    _argumentsRead = true;
    final args = ModalRoute.of(context)?.settings.arguments;
    final selectedId = args is Map ? args['doctorId'] : null;
    if (kDebugMode) {
      debugPrint(
        '[Doctor] Details argument received: ${args is Map ? 'map' : 'missing or invalid'}',
      );
    }
    if (selectedId is String &&
        RegExp(r'^[0-9a-fA-F]{24}$').hasMatch(selectedId)) {
      doctorId = selectedId;
      if (kDebugMode) debugPrint('[Doctor] Selected doctor ID: $doctorId');
      _loadDoctorDetails();
    } else {
      isLoading = false;
      errorMessage = 'No doctor selected';
    }
  }

  Future<void> _loadDoctorDetails() async {
    if (doctorId == null) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final result = await DoctorService.getDoctorById(doctorId!);

    if (mounted) {
      setState(() {
        isLoading = false;
        if (result['success'] == true) {
          doctor = result['data']['doctor'];
        } else {
          errorMessage = result['message'] ?? 'Failed to load doctor details';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Doctor Details')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Doctor Details')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: AppSpacing.md),
                Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: AppSpacing.md),
                ElevatedButton(
                  onPressed: doctorId == null
                      ? () => Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.doctorList,
                        )
                      : _loadDoctorDetails,
                  child: Text(doctorId == null ? 'Select a Doctor' : 'Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (doctor == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Doctor Details')),
        body: const Center(child: Text('No doctor data available')),
      );
    }

    final doctorName = doctor?['name']?.toString() ?? 'Unknown';
    final qualification = doctor?['qualification']?.toString() ?? '';
    final specialization = doctor?['specialty']?.toString() ?? '';
    final hospital = doctor?['hospital']?.toString() ?? '';
    final location = doctor?['location']?.toString() ?? '';
    final experience = doctor?['experienceYears']?.toString() ?? '0';
    final rating = doctor?['rating']?.toString() ?? '0';
    final reviewCount = doctor?['reviewCount']?.toString() ?? '0';
    final fee = doctor?['consultationFee']?.toString() ?? '0';
    final about = doctor?['about']?.toString() ?? '';
    final languages = doctor?['languages'] as List<dynamic>? ?? [];
    final availableSlots = doctor?['availableSlots'] as List<dynamic>? ?? [];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryBlue,
                          AppColors.primaryBlueLight,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: AppSpacing.md,
                    left: AppSpacing.md,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Transform.translate(
                offset: const Offset(0, -60),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.surfaceWhite,
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        doctorName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$qualification - $specialization',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryGrey,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      DoctorRatingWidget(
                        rating: double.tryParse(rating) ?? 0,
                        reviewCount: int.tryParse(reviewCount) ?? 0,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      DoctorStatisticsCard(
                        patientsServed: (int.tryParse(reviewCount) ?? 0) * 10,
                        yearsExperience: int.tryParse(experience) ?? 0,
                        rating: double.tryParse(rating) ?? 0,
                        reviewsCount: int.tryParse(reviewCount) ?? 0,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      if (about.isNotEmpty) ...[
                        const SectionTitle(title: 'About Doctor'),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          about,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondaryGrey,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                      ],
                      const SectionTitle(title: 'Hospital'),
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceWhite,
                          borderRadius: BorderRadius.circular(AppRadius.large),
                          border: Border.all(
                            color: AppColors.backgroundLightGreyDark,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.local_hospital),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hospital,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (location.isNotEmpty)
                                    Text(
                                      location,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondaryGrey,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      if (languages.isNotEmpty) ...[
                        const SectionTitle(title: 'Languages'),
                        const SizedBox(height: AppSpacing.md),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          children: languages
                              .map<Widget>(
                                (lang) => Chip(
                                  label: Text(lang.toString()),
                                  backgroundColor: AppColors.primaryBlue
                                      .withValues(alpha: 0.1),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                      ],
                      const SectionTitle(title: 'Available Timings'),
                      const SizedBox(height: AppSpacing.md),
                      DoctorAvailabilityCard(
                        todaySlots: availableSlots
                            .take(4)
                            .cast<String>()
                            .toList(),
                        tomorrowSlots: availableSlots
                            .skip(4)
                            .take(4)
                            .cast<String>()
                            .toList(),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Consultation Fee',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textSecondaryGrey,
                              ),
                            ),
                          ),
                          Text(
                            '₹$fee',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      PrimaryButton(
                        text: 'Book Appointment',
                        onPressed: () {
                          if (kDebugMode) {
                            debugPrint('[Appointment] Book button tapped');
                            debugPrint('[Appointment] Doctor ID: $doctorId');
                          }
                          Navigator.pushNamed(
                            context,
                            AppRoutes.bookAppointment,
                            arguments: {
                              'doctorId': doctorId,
                              'doctorName': doctorName,
                              'specialization': specialization,
                              'hospital': hospital,
                              'fee': fee,
                              'availableSlots': availableSlots,
                            },
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.xl),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
