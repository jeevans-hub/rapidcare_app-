import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';
import '../../widgets/primary_button.dart';

class AppointmentConfirmationScreen extends StatelessWidget {
  const AppointmentConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final appointment = args?['appointment'];
    final doctor = args?['doctor'];

    final doctorName =
        doctor?['doctorName'] ?? appointment?['doctor']?['name'] ?? 'Doctor';
    final hospital =
        doctor?['hospital'] ?? appointment?['doctor']?['hospital'] ?? '';
    final appointmentDate = appointment?['appointmentDate'];
    final timeSlot = appointment?['timeSlot'] ?? '';
    final appointmentId = appointment?['_id']?.toString() ?? '';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 60,
                  color: AppColors.successGreen,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              const Text(
                'Appointment Confirmed!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Your appointment has been successfully booked.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondaryGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(AppRadius.large),
                  border: Border.all(color: AppColors.backgroundLightGreyDark),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ConfirmationRow(
                      icon: Icons.person,
                      label: 'Doctor',
                      value: doctorName,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    if (hospital.isNotEmpty)
                      _ConfirmationRow(
                        icon: Icons.local_hospital,
                        label: 'Hospital',
                        value: hospital,
                      ),
                    const SizedBox(height: AppSpacing.md),
                    if (appointmentDate != null)
                      _ConfirmationRow(
                        icon: Icons.calendar_today,
                        label: 'Date',
                        value: _formatDate(appointmentDate),
                      ),
                    const SizedBox(height: AppSpacing.md),
                    if (timeSlot.isNotEmpty)
                      _ConfirmationRow(
                        icon: Icons.access_time,
                        label: 'Time',
                        value: timeSlot,
                      ),
                    const SizedBox(height: AppSpacing.md),
                    _ConfirmationRow(
                      icon: Icons.video_call,
                      label: 'Consultation',
                      value: 'In-Person Visit',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const Divider(),
                    const SizedBox(height: AppSpacing.md),
                    if (appointmentId.isNotEmpty)
                      _ConfirmationRow(
                        icon: Icons.confirmation_number,
                        label: 'Appointment ID',
                        value: appointmentId.substring(0, 8),
                        isBold: true,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                text: 'View My Appointments',
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.appointments,
                  );
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
                child: const Text('Back to Dashboard'),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return '';
    try {
      final dateTime = DateTime.parse(date.toString()).toLocal();
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return date.toString();
    }
  }
}

class _ConfirmationRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isBold;

  const _ConfirmationRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primaryBlue),
        const SizedBox(width: AppSpacing.md),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondaryGrey,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold
                  ? AppColors.primaryBlue
                  : AppColors.textPrimaryDarkGrey,
            ),
          ),
        ),
      ],
    );
  }
}
