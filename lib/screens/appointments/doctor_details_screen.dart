import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';
import '../../widgets/appointments/doctor_rating_widget.dart';
import '../../widgets/doctors/doctor_widgets.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
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
                      const Text(
                        'Dr. Sarah Johnson',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'MBBS, MD - Cardiologist',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryGrey,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const DoctorRatingWidget(rating: 4.8, reviewCount: 234),
                      const SizedBox(height: AppSpacing.md),
                      const DoctorStatisticsCard(
                        patientsServed: 5000,
                        yearsExperience: 12,
                        rating: 4.8,
                        reviewsCount: 320,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      const SectionTitle(title: 'About Doctor'),
                      const SizedBox(height: AppSpacing.md),
                      const Text(
                        'Dr. Sarah Johnson is a highly experienced cardiologist with over 12 years of experience in treating heart conditions. She specializes in interventional cardiology and has successfully treated thousands of patients.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryGrey,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      const SectionTitle(title: 'Hospital'),
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceWhite,
                          borderRadius: BorderRadius.circular(AppRadius.large),
                          border: Border.all(color: AppColors.backgroundLightGreyDark),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.local_hospital),
                            const SizedBox(width: AppSpacing.md),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'City General Hospital',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '123 Medical Center, New York',
                                    style: TextStyle(
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
                      DoctorExperienceCard(
                        experiences: [
                          ExperienceItem(
                            hospital: 'City General Hospital',
                            role: 'Senior Cardiologist',
                            duration: '2018 - Present',
                          ),
                          ExperienceItem(
                            hospital: 'Metro Medical Center',
                            role: 'Cardiologist',
                            duration: '2014 - 2018',
                          ),
                          ExperienceItem(
                            hospital: 'St. Mary\'s Hospital',
                            role: 'Resident Cardiologist',
                            duration: '2012 - 2014',
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      DoctorAwardsCard(
                        awards: [
                          AwardItem(
                            title: 'Best Cardiologist Award',
                            year: '2023',
                            description: 'Awarded for excellence in patient care',
                          ),
                          AwardItem(
                            title: 'Medical Research Excellence',
                            year: '2021',
                            description: 'Recognized for contributions to cardiac research',
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      const SectionTitle(title: 'Available Timings'),
                      const SizedBox(height: AppSpacing.md),
                      const DoctorAvailabilityCard(
                        todaySlots: [
                          '10:00 AM',
                          '11:30 AM',
                          '02:00 PM',
                          '04:30 PM',
                        ],
                        tomorrowSlots: [
                          '09:00 AM',
                          '11:00 AM',
                          '03:00 PM',
                          '05:00 PM',
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      DoctorReviewsSection(
                        reviews: [
                          ReviewItem(
                            patientName: 'John Smith',
                            rating: 5.0,
                            date: 'Aug 10, 2026',
                            reviewText: 'Excellent doctor, very professional and caring.',
                          ),
                          ReviewItem(
                            patientName: 'Emily Johnson',
                            rating: 5.0,
                            date: 'Aug 8, 2026',
                            reviewText: 'Dr. Sarah explained everything clearly. Highly recommended!',
                          ),
                        ],
                        onViewAll: () {
                          Navigator.pushNamed(context, AppRoutes.doctorReviews);
                        },
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
                            '₹600',
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
                          Navigator.pushNamed(context, AppRoutes.bookAppointment);
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
