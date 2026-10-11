import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';
import '../../widgets/appointments/appointment_date_selector.dart';
import '../../widgets/appointments/time_slot_section.dart';
import '../../widgets/appointments/booking_success_dialog.dart';
import '../../services/appointment_service.dart';
import '../../services/doctor_service.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  Map<String, dynamic>? doctorData;
  String? selectedDate;
  String? selectedTimeSlot;
  String? reason;
  bool isBooking = false;
  bool isLoadingSlots = false;
  List<String> availableSlots = [];
  int _slotVersion = 0;
  String? errorMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic> &&
        args['doctorId'] is String &&
        RegExp(r'^[0-9a-fA-F]{24}$').hasMatch(args['doctorId']) &&
        doctorData == null) {
      doctorData = args;
    }
  }

  Future<void> _loadSlots(String date) async {
    final version = ++_slotVersion;
    setState(() {
      selectedDate = date;
      selectedTimeSlot = null;
      availableSlots = [];
      isLoadingSlots = true;
      errorMessage = null;
    });
    final result = await DoctorService.getAvailability(
      doctorData!['doctorId'],
      date,
    );
    if (!mounted || version != _slotVersion) return;
    setState(() {
      isLoadingSlots = false;
      if (result['success'] == true) {
        availableSlots = List<String>.from(result['data']['slots']);
      } else {
        errorMessage = result['message'];
      }
    });
  }

  Future<void> _bookAppointment() async {
    if (isBooking || isLoadingSlots) return;
    if (kDebugMode) debugPrint('[Appointment] Book button tapped');
    if (doctorData == null ||
        selectedDate == null ||
        selectedTimeSlot == null ||
        !availableSlots.contains(selectedTimeSlot)) {
      setState(() {
        errorMessage = 'Please select date and time slot';
      });
      return;
    }

    setState(() {
      isBooking = true;
      errorMessage = null;
    });

    final result = await AppointmentService.createAppointment(
      doctorId: doctorData!['doctorId'] ?? '',
      appointmentDate: selectedDate!,
      timeSlot: selectedTimeSlot!,
      reason: reason ?? 'General consultation',
    );

    if (mounted) {
      setState(() {
        isBooking = false;
      });

      if (result['success'] == true) {
        final appointment = result['data']['appointment'];
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) => BookingSuccessDialog(
            isDemo:
                appointment['isDemo'] == true || doctorData?['isDemo'] == true,
          ),
        ).then((_) {
          if (mounted) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.appointmentConfirmation,
              arguments: {'appointment': appointment, 'doctor': doctorData},
            );
          }
        });
      } else {
        setState(() {
          errorMessage = result['message'] ?? 'Failed to book appointment';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (doctorData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Book Appointment')),
        body: const Center(child: Text('No doctor selected')),
      );
    }

    final doctorName = doctorData!['doctorName'] ?? 'Doctor';
    final hospital = doctorData!['hospital'] ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (doctorData!['isDemo'] == true)
                const Text(
                  'Demo booking — testing only. No clinic is contacted and no payment is collected.',
                ),
              // Doctor summary
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.backgroundLightGreyDark),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (hospital.isNotEmpty)
                      Text(
                        hospital,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryGrey,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              const SectionTitle(title: 'Select Date'),
              const SizedBox(height: AppSpacing.md),
              AppointmentDateSelector(
                availableDays: (doctorData!['availableDays'] as List<dynamic>?)
                    ?.cast<String>(),
                onDateSelected: _loadSlots,
              ),
              const SizedBox(height: AppSpacing.xl),
              const SectionTitle(title: 'Available Time Slots'),
              const SizedBox(height: AppSpacing.md),
              if (isLoadingSlots)
                const Center(child: CircularProgressIndicator())
              else if (selectedDate == null)
                const Text('Select a date to see available slots (IST).')
              else if (availableSlots.isEmpty)
                const Text('No available slots for this date.')
              else
                TimeSlotSection(
                  key: ValueKey('$selectedDate-$_slotVersion'),
                  availableSlots: availableSlots.cast<String>(),
                  onSlotSelected: (slot) {
                    setState(() {
                      selectedTimeSlot = slot;
                      if (kDebugMode) {
                        debugPrint(
                          '[Appointment] Date/time selected: time=$slot',
                        );
                      }
                    });
                  },
                ),
              const SizedBox(height: AppSpacing.xl),
              const SectionTitle(title: 'Reason for Visit'),
              const SizedBox(height: AppSpacing.md),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Describe your reason for visit (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(AppSpacing.md),
                ),
                onChanged: (value) {
                  setState(() {
                    reason = value;
                  });
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              if (errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.errorRed.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 20),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                text: isBooking ? 'Booking...' : 'Book Appointment',
                onPressed: isBooking || isLoadingSlots
                    ? null
                    : _bookAppointment,
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
