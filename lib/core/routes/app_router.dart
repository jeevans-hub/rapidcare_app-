import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/auth/forgot_password_screen.dart';
import '../../screens/auth/otp_verification_screen.dart';
import '../../screens/auth/reset_password_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/appointments/appointment_screen.dart';
import '../../screens/appointments/doctor_list_screen.dart';
import '../../screens/appointments/doctor_details_screen.dart';
import '../../screens/appointments/book_appointment_screen.dart';
import '../../screens/appointments/appointment_confirmation_screen.dart';
import '../../screens/emergency/emergency_screen.dart';
import '../../screens/emergency/emergency_home_screen.dart';
import '../../screens/emergency/ambulance_request_screen.dart';
import '../../screens/emergency/emergency_contacts_screen.dart';
import '../../screens/emergency/first_aid_screen.dart';
import '../../screens/pharmacy/pharmacy_screen.dart';
import '../../screens/pharmacy/pharmacy_home_screen.dart';
import '../../screens/pharmacy/medicine_details_screen.dart';
import '../../screens/pharmacy/pharmacy_cart_screen.dart';
import '../../screens/pharmacy/prescription_screen.dart';
import '../../screens/pharmacy/pharmacy_order_confirmation_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/profile/edit_profile_screen.dart';
import '../../screens/profile/medical_information_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/settings/notification_settings_screen.dart';
import '../../screens/settings/privacy_security_screen.dart';
import '../../screens/settings/help_support_screen.dart';
import '../../screens/settings/about_screen.dart';
import '../../screens/medical_records/medical_records_screen.dart';
import '../../screens/medical_records/medical_record_details_screen.dart';
import '../../screens/medical_records/prescription_records_screen.dart';
import '../../screens/medical_records/lab_reports_screen.dart';
import '../../screens/medical_records/doctor_reports_screen.dart';
import '../../screens/health/health_home_screen.dart';
import '../../screens/health/health_metrics_screen.dart';
import '../../screens/health/health_goals_screen.dart';
import '../../screens/health/wellness_tips_screen.dart';
import '../../screens/health/health_summary_screen.dart';
import '../../screens/doctors/doctor_specialties_screen.dart';
import '../../screens/doctors/doctor_reviews_screen.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );
      case AppRoutes.otpVerification:
        return MaterialPageRoute(
          builder: (_) => const OTPVerificationScreen(),
        );
      case AppRoutes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case AppRoutes.appointments:
        return MaterialPageRoute(
          builder: (_) => const AppointmentScreen(),
        );
      case AppRoutes.doctorList:
        return MaterialPageRoute(
          builder: (_) => const DoctorListScreen(),
        );
      case AppRoutes.doctorDetails:
        return MaterialPageRoute(
          builder: (_) => const DoctorDetailsScreen(),
        );
      case AppRoutes.bookAppointment:
        return MaterialPageRoute(
          builder: (_) => const BookAppointmentScreen(),
        );
      case AppRoutes.doctorSpecialties:
        return MaterialPageRoute(
          builder: (_) => const DoctorSpecialtiesScreen(),
        );
      case AppRoutes.doctorReviews:
        return MaterialPageRoute(
          builder: (_) => const DoctorReviewsScreen(),
        );
      case AppRoutes.appointmentConfirmation:
        return MaterialPageRoute(
          builder: (_) => const AppointmentConfirmationScreen(),
        );
      case AppRoutes.emergency:
        return MaterialPageRoute(
          builder: (_) => const EmergencyScreen(),
        );
      case AppRoutes.emergencyHome:
        return MaterialPageRoute(
          builder: (_) => const EmergencyHomeScreen(),
        );
      case AppRoutes.ambulanceRequest:
        return MaterialPageRoute(
          builder: (_) => const AmbulanceRequestScreen(),
        );
      case AppRoutes.emergencyContacts:
        return MaterialPageRoute(
          builder: (_) => const EmergencyContactsScreen(),
        );
      case AppRoutes.firstAid:
        return MaterialPageRoute(
          builder: (_) => const FirstAidScreen(),
        );
      case AppRoutes.pharmacy:
        return MaterialPageRoute(
          builder: (_) => const PharmacyScreen(),
        );
      case AppRoutes.pharmacyHome:
        return MaterialPageRoute(
          builder: (_) => const PharmacyHomeScreen(),
        );
      case AppRoutes.medicineDetails:
        return MaterialPageRoute(
          builder: (_) => const MedicineDetailsScreen(),
        );
      case AppRoutes.pharmacyCart:
        return MaterialPageRoute(
          builder: (_) => const PharmacyCartScreen(),
        );
      case AppRoutes.prescription:
        return MaterialPageRoute(
          builder: (_) => const PrescriptionScreen(),
        );
      case AppRoutes.pharmacyOrderConfirmation:
        return MaterialPageRoute(
          builder: (_) => const PharmacyOrderConfirmationScreen(),
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case AppRoutes.editProfile:
        return MaterialPageRoute(
          builder: (_) => const EditProfileScreen(),
        );
      case AppRoutes.medicalInformation:
        return MaterialPageRoute(
          builder: (_) => const MedicalInformationScreen(),
        );
      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
      case AppRoutes.notificationSettings:
        return MaterialPageRoute(
          builder: (_) => const NotificationSettingsScreen(),
        );
      case AppRoutes.privacySecurity:
        return MaterialPageRoute(
          builder: (_) => const PrivacySecurityScreen(),
        );
      case AppRoutes.helpSupport:
        return MaterialPageRoute(
          builder: (_) => const HelpSupportScreen(),
        );
      case AppRoutes.about:
        return MaterialPageRoute(
          builder: (_) => const AboutScreen(),
        );
      case AppRoutes.medicalRecords:
        return MaterialPageRoute(
          builder: (_) => const MedicalRecordsScreen(),
        );
      case AppRoutes.medicalRecordDetails:
        return MaterialPageRoute(
          builder: (_) => const MedicalRecordDetailsScreen(),
        );
      case AppRoutes.prescriptionRecords:
        return MaterialPageRoute(
          builder: (_) => const PrescriptionRecordsScreen(),
        );
      case AppRoutes.labReports:
        return MaterialPageRoute(
          builder: (_) => const LabReportsScreen(),
        );
      case AppRoutes.doctorReports:
        return MaterialPageRoute(
          builder: (_) => const DoctorReportsScreen(),
        );
      case AppRoutes.healthHome:
        return MaterialPageRoute(
          builder: (_) => const HealthHomeScreen(),
        );
      case AppRoutes.healthMetrics:
        return MaterialPageRoute(
          builder: (_) => const HealthMetricsScreen(),
        );
      case AppRoutes.healthGoals:
        return MaterialPageRoute(
          builder: (_) => const HealthGoalsScreen(),
        );
      case AppRoutes.wellnessTips:
        return MaterialPageRoute(
          builder: (_) => const WellnessTipsScreen(),
        );
      case AppRoutes.healthSummary:
        return MaterialPageRoute(
          builder: (_) => const HealthSummaryScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}
