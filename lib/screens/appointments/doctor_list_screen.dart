import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import '../../widgets/appointments/doctor_search_bar.dart';
import '../../widgets/appointments/speciality_filter_section.dart';
import '../../widgets/appointments/doctor_card.dart';
import '../../services/doctor_service.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  List<dynamic> doctors = [];
  bool isLoading = true;
  String? errorMessage;
  String? selectedSpecialty;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  Future<void> _loadDoctors() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final result = await DoctorService.getDoctors(
      search: searchQuery.isNotEmpty ? searchQuery : null,
      specialty: selectedSpecialty,
    );

    if (mounted) {
      setState(() {
        isLoading = false;
        if (result['success'] == true) {
          doctors = result['data']['doctors'] ?? [];
        } else {
          errorMessage = result['message'] ?? 'Failed to load doctors';
          doctors = [];
        }
      });
    }
  }

  void _onSearchChanged(String query) {
    searchQuery = query;
    _loadDoctors();
  }

  void _onSpecialtySelected(String specialty) {
    selectedSpecialty = specialty == 'All' ? null : specialty;
    _loadDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Doctors'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search and filters section
            SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorSearchBar(
                    onChanged: _onSearchChanged,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const SectionTitle(title: 'Specialities'),
                  const SizedBox(height: AppSpacing.md),
                  SpecialityFilterSection(
                    onSpecialtySelected: _onSpecialtySelected,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const SectionTitle(title: 'Available Doctors'),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
            // Doctor list
            Expanded(
              child: _buildDoctorList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorList() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.red,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: AppSpacing.md),
              ElevatedButton(
                onPressed: _loadDoctors,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (doctors.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_search,
                size: 48,
                color: Colors.grey,
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'No doctors found',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: DoctorCard(
            doctorName: doctor['name'] ?? 'Unknown',
            qualification: doctor['qualification'] ?? '',
            specialization: doctor['specialty'] ?? '',
            hospital: doctor['hospital'] ?? '',
            experience: doctor['experienceYears'] ?? 0,
            rating: (doctor['rating'] ?? 0).toDouble(),
            reviewCount: doctor['reviewCount'] ?? 0,
            fee: doctor['consultationFee'] ?? 0,
            isAvailableToday: doctor['isAvailable'] ?? true,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.doctorDetails,
                arguments: {
                  'doctorId': doctor['_id'],
                  'doctorName': doctor['name'],
                  'qualification': doctor['qualification'],
                  'specialization': doctor['specialty'],
                  'hospital': doctor['hospital'],
                  'experience': doctor['experienceYears'],
                  'rating': doctor['rating'],
                  'reviewCount': doctor['reviewCount'],
                  'fee': doctor['consultationFee'],
                  'about': doctor['about'],
                  'location': doctor['location'],
                  'languages': doctor['languages'],
                  'availableDays': doctor['availableDays'],
                  'availableSlots': doctor['availableSlots'],
                },
              );
            },
          ),
        );
      },
    );
  }
}
