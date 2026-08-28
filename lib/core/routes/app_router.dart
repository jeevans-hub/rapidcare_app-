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
import '../../screens/medical_records/add_medical_record_screen.dart';
import '../../screens/medical_records/prescription_records_screen.dart';
import '../../screens/medical_records/lab_reports_screen.dart';
import '../../screens/medical_records/doctor_reports_screen.dart';
import '../../screens/health/health_home_screen.dart';
import '../../screens/health/health_metrics_screen.dart';
import '../../screens/health/wellness_tips_screen.dart';
import '../../screens/health/health_summary_screen.dart';
import '../../screens/doctors/doctor_specialties_screen.dart';
import '../../screens/doctors/doctor_reviews_screen.dart';
import '../../screens/notifications/notifications_screen.dart';
import '../../screens/notifications/notification_details_screen.dart';
import '../../screens/notifications/reminders_screen.dart';
import '../../screens/notifications/reminder_details_screen.dart';
import '../../screens/notifications/notification_preferences_screen.dart';
import '../../screens/healthcare_services/healthcare_services_screen.dart';
import '../../screens/healthcare_services/healthcare_service_details_screen.dart';
import '../../screens/healthcare_services/healthcare_service_categories_screen.dart';
import '../../screens/healthcare_services/home_healthcare_screen.dart';
import '../../screens/healthcare_services/laboratory_services_screen.dart';
import '../../screens/healthcare_services/health_packages_screen.dart';
import '../../screens/health_insurance/health_insurance_screen.dart';
import '../../screens/health_insurance/insurance_plan_details_screen.dart';
import '../../screens/health_insurance/insurance_categories_screen.dart';
import '../../screens/health_insurance/my_insurance_screen.dart';
import '../../screens/health_insurance/insurance_claims_screen.dart';
import '../../screens/health_insurance/insurance_claim_details_screen.dart';
import '../../screens/health_insurance/insurance_documents_screen.dart';
import '../../screens/health_insurance/insurance_help_screen.dart';
import '../../screens/health_education/health_education_screen.dart';
import '../../screens/health_education/health_article_details_screen.dart';
import '../../screens/health_education/health_categories_screen.dart';
import '../../screens/health_education/health_tips_screen.dart';
import '../../screens/health_education/first_aid_screen.dart' as health_edu;
import '../../screens/health_education/health_faq_screen.dart';
import '../../screens/health_education/wellness_resources_screen.dart';
import '../../screens/health_monitoring/health_monitoring_screen.dart';
import '../../screens/health_monitoring/health_metric_details_screen.dart';
import '../../screens/health_monitoring/health_vitals_screen.dart';
import '../../screens/health_monitoring/health_activity_screen.dart';
import '../../screens/health_monitoring/health_goals_screen.dart' as health_monitoring;
import '../../screens/health_monitoring/health_history_screen.dart';
import '../../screens/health_monitoring/health_monitoring_help_screen.dart';
import '../../screens/health_reports/health_reports_screen.dart';
import '../../screens/health_reports/health_report_details_screen.dart';
import '../../screens/health_reports/health_report_types_screen.dart';
import '../../screens/health_reports/health_report_history_screen.dart';
import '../../screens/health_reports/health_report_analytics_screen.dart';
import '../../screens/health_reports/health_report_comparison_screen.dart';
import '../../screens/health_reports/health_reports_help_screen.dart';

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
      case AppRoutes.notifications:
        return MaterialPageRoute(
          builder: (_) => const NotificationsScreen(),
        );
      case AppRoutes.notificationDetails:
        return MaterialPageRoute(
          builder: (_) => const NotificationDetailsScreen(),
        );
      case AppRoutes.reminders:
        return MaterialPageRoute(
          builder: (_) => const RemindersScreen(),
        );
      case AppRoutes.reminderDetails:
        return MaterialPageRoute(
          builder: (_) => const ReminderDetailsScreen(),
        );
      case AppRoutes.notificationPreferences:
        return MaterialPageRoute(
          builder: (_) => const NotificationPreferencesScreen(),
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
      case AppRoutes.addMedicalRecord:
        return MaterialPageRoute(
          builder: (_) => const AddMedicalRecordScreen(),
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
      case AppRoutes.wellnessTips:
        return MaterialPageRoute(
          builder: (_) => const WellnessTipsScreen(),
        );
      case AppRoutes.healthSummary:
        return MaterialPageRoute(
          builder: (_) => const HealthSummaryScreen(),
        );
      case AppRoutes.healthcareServices:
        return MaterialPageRoute(
          builder: (_) => const HealthcareServicesScreen(),
        );
      case AppRoutes.healthcareServiceDetails:
        return MaterialPageRoute(
          builder: (_) => const HealthcareServiceDetailsScreen(),
        );
      case AppRoutes.healthcareServiceCategories:
        return MaterialPageRoute(
          builder: (_) => HealthcareServiceCategoriesScreen(),
        );
      case AppRoutes.homeHealthcare:
        return MaterialPageRoute(
          builder: (_) => HomeHealthcareScreen(),
        );
      case AppRoutes.laboratoryServices:
        return MaterialPageRoute(
          builder: (_) => LaboratoryServicesScreen(),
        );
      case AppRoutes.healthPackages:
        return MaterialPageRoute(
          builder: (_) => HealthPackagesScreen(),
        );
      case AppRoutes.healthInsurance:
        return MaterialPageRoute(
          builder: (_) => const HealthInsuranceScreen(),
        );
      case AppRoutes.insurancePlanDetails:
        return MaterialPageRoute(
          builder: (_) => const InsurancePlanDetailsScreen(),
        );
      case AppRoutes.insuranceCategories:
        return MaterialPageRoute(
          builder: (_) => InsuranceCategoriesScreen(),
        );
      case AppRoutes.myInsurance:
        return MaterialPageRoute(
          builder: (_) => MyInsuranceScreen(),
        );
      case AppRoutes.insuranceClaims:
        return MaterialPageRoute(
          builder: (_) => InsuranceClaimsScreen(),
        );
      case AppRoutes.insuranceClaimDetails:
        return MaterialPageRoute(
          builder: (_) => InsuranceClaimDetailsScreen(),
        );
      case AppRoutes.insuranceDocuments:
        return MaterialPageRoute(
          builder: (_) => InsuranceDocumentsScreen(),
        );
      case AppRoutes.insuranceHelp:
        return MaterialPageRoute(
          builder: (_) => InsuranceHelpScreen(),
        );
      case AppRoutes.healthEducation:
        return MaterialPageRoute(
          builder: (_) => const HealthEducationScreen(),
        );
      case AppRoutes.healthArticleDetails:
        return MaterialPageRoute(
          builder: (_) => const HealthArticleDetailsScreen(),
        );
      case AppRoutes.healthCategories:
        return MaterialPageRoute(
          builder: (_) => HealthCategoriesScreen(),
        );
      case AppRoutes.healthTips:
        return MaterialPageRoute(
          builder: (_) => HealthTipsScreen(),
        );
      case AppRoutes.healthFirstAid:
        return MaterialPageRoute(
          builder: (_) => health_edu.HealthFirstAidScreen(),
        );
      case AppRoutes.healthFaq:
        return MaterialPageRoute(
          builder: (_) => HealthFaqScreen(),
        );
      case AppRoutes.wellnessResources:
        return MaterialPageRoute(
          builder: (_) => WellnessResourcesScreen(),
        );
      case AppRoutes.healthMonitoring:
        return MaterialPageRoute(
          builder: (_) => const HealthMonitoringScreen(),
        );
      case AppRoutes.healthMetricDetails:
        return MaterialPageRoute(
          builder: (_) => const HealthMetricDetailsScreen(),
        );
      case AppRoutes.healthVitals:
        return MaterialPageRoute(
          builder: (_) => HealthVitalsScreen(),
        );
      case AppRoutes.healthActivity:
        return MaterialPageRoute(
          builder: (_) => HealthActivityScreen(),
        );
      case AppRoutes.healthGoals:
        return MaterialPageRoute(
          builder: (_) => health_monitoring.HealthGoalsScreen(),
        );
      case AppRoutes.healthHistory:
        return MaterialPageRoute(
          builder: (_) => HealthHistoryScreen(),
        );
      case AppRoutes.healthMonitoringHelp:
        return MaterialPageRoute(
          builder: (_) => HealthMonitoringHelpScreen(),
        );
      case AppRoutes.healthReports:
        return MaterialPageRoute(
          builder: (_) => HealthReportsScreen(),
        );
      case AppRoutes.healthReportDetails:
        return MaterialPageRoute(
          builder: (_) => HealthReportDetailsScreen(),
        );
      case AppRoutes.healthReportTypes:
        return MaterialPageRoute(
          builder: (_) => const HealthReportTypesScreen(),
        );
      case AppRoutes.healthReportHistory:
        return MaterialPageRoute(
          builder: (_) => const HealthReportHistoryScreen(),
        );
      case AppRoutes.healthReportAnalytics:
        return MaterialPageRoute(
          builder: (_) => const HealthReportAnalyticsScreen(),
        );
      case AppRoutes.healthReportComparison:
        return MaterialPageRoute(
          builder: (_) => const HealthReportComparisonScreen(),
        );
      case AppRoutes.healthReportsHelp:
        return MaterialPageRoute(
          builder: (_) => const HealthReportsHelpScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}
