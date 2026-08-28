import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../services/appointment_service.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  List<dynamic> appointments = [];
  bool isLoading = true;
  String? errorMessage;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final result = await AppointmentService.getUserAppointments(
      status: selectedStatus,
    );

    if (mounted) {
      setState(() {
        isLoading = false;
        if (result['success'] == true) {
          appointments = result['data']['appointments'] ?? [];
        } else {
          errorMessage = result['message'] ?? 'Failed to load appointments';
          appointments = [];
        }
      });
    }
  }

  void _onStatusFilterChanged(String? status) {
    selectedStatus = status;
    _loadAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: _onStatusFilterChanged,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: null,
                child: Text('All'),
              ),
              const PopupMenuItem(
                value: 'scheduled',
                child: Text('Scheduled'),
              ),
              const PopupMenuItem(
                value: 'completed',
                child: Text('Completed'),
              ),
              const PopupMenuItem(
                value: 'cancelled',
                child: Text('Cancelled'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Appointments',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (selectedStatus != null)
                    Chip(
                      label: Text(selectedStatus!),
                      onDeleted: () => _onStatusFilterChanged(null),
                    ),
                ],
              ),
            ),
            Expanded(
              child: _buildAppointmentList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.doctorList);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAppointmentList() {
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
                onPressed: _loadAppointments,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (appointments.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.event_busy,
                size: 48,
                color: Colors.grey,
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'No appointments found',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                selectedStatus != null
                    ? 'Try changing the filter'
                    : 'Book your first appointment',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        final doctor = appointment['doctor'] ?? {};
        return _AppointmentCard(
          doctorName: doctor['name'] ?? 'Unknown Doctor',
          specialty: doctor['specialty'] ?? '',
          hospital: doctor['hospital'] ?? '',
          appointmentDate: appointment['appointmentDate'],
          timeSlot: appointment['timeSlot'] ?? '',
          status: appointment['status'] ?? 'scheduled',
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
        );
      },
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String hospital;
  final dynamic appointmentDate;
  final String timeSlot;
  final String status;
  final VoidCallback onTap;

  const _AppointmentCard({
    required this.doctorName,
    required this.specialty,
    required this.hospital,
    required this.appointmentDate,
    required this.timeSlot,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;

    switch (status) {
      case 'scheduled':
        statusColor = AppColors.primaryBlue;
        statusText = 'Scheduled';
        break;
      case 'completed':
        statusColor = AppColors.successGreen;
        statusText = 'Completed';
        break;
      case 'cancelled':
        statusColor = Colors.red;
        statusText = 'Cancelled';
        break;
      default:
        statusColor = Colors.grey;
        statusText = status;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      doctorName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 12,
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              if (specialty.isNotEmpty)
                Text(
                  specialty,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryBlue,
                  ),
                ),
              const SizedBox(height: AppSpacing.sm),
              if (hospital.isNotEmpty)
                Text(
                  hospital,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondaryGrey,
                  ),
                ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(appointmentDate),
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    timeSlot,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return '';
    try {
      final dateTime = DateTime.parse(date.toString());
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return date.toString();
    }
  }
}
