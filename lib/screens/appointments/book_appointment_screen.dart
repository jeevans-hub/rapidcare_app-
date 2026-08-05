import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';
import '../../widgets/appointments/appointment_date_selector.dart';
import '../../widgets/appointments/time_slot_section.dart';
import '../../widgets/appointments/consultation_type_selector.dart';
import '../../widgets/appointments/patient_selector.dart';
import '../../widgets/appointments/appointment_summary_card.dart';
import '../../widgets/appointments/booking_success_dialog.dart';

class BookAppointmentScreen extends StatelessWidget {
  const BookAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: 'Select Date'),
              const SizedBox(height: AppSpacing.md),
              const AppointmentDateSelector(),
              const SizedBox(height: AppSpacing.xl),
              const TimeSlotSection(),
              const SizedBox(height: AppSpacing.xl),
              const PatientSelector(),
              const SizedBox(height: AppSpacing.xl),
              const ConsultationTypeSelector(),
              const SizedBox(height: AppSpacing.xl),
              const AppointmentSummaryCard(),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                text: 'Book Appointment',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const BookingSuccessDialog(),
                  ).then((_) {
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.appointmentConfirmation,
                      );
                    }
                  });
                },
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
