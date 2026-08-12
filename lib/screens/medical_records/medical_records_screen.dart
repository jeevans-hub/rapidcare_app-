import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/medical_records/medical_records_widgets.dart';

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({super.key});

  @override
  State<MedicalRecordsScreen> createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> {
  String _selectedFilter = 'All';

  final List<MedicalRecordItem> _allRecords = [
    MedicalRecordItem(
      icon: Icons.biotech,
      title: 'Blood Test',
      doctorOrHospital: 'City Care Hospital',
      date: '10 Aug 2026',
      type: 'Lab Report',
    ),
    MedicalRecordItem(
      icon: Icons.local_hospital,
      title: 'General Consultation',
      doctorOrHospital: 'Dr. Sarah Johnson',
      date: '05 Aug 2026',
      type: 'Doctor Report',
    ),
    MedicalRecordItem(
      icon: Icons.medication,
      title: 'Prescription',
      doctorOrHospital: 'Dr. Michael Lee',
      date: '02 Aug 2026',
      type: 'Prescription',
    ),
    MedicalRecordItem(
      icon: Icons.biotech,
      title: 'Complete Blood Count',
      doctorOrHospital: 'City Care Hospital',
      date: '28 Jul 2026',
      type: 'Lab Report',
    ),
    MedicalRecordItem(
      icon: Icons.local_hospital,
      title: 'Cardiac Checkup',
      doctorOrHospital: 'Dr. Emily Davis',
      date: '20 Jul 2026',
      type: 'Doctor Report',
    ),
  ];

  List<MedicalRecordItem> get _filteredRecords {
    if (_selectedFilter == 'All') return _allRecords;
    return _allRecords.where((record) {
      switch (_selectedFilter) {
        case 'Prescriptions':
          return record.type == 'Prescription';
        case 'Lab Reports':
          return record.type == 'Lab Report';
        case 'Doctor Reports':
          return record.type == 'Doctor Report';
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Records'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: MedicalRecordsHeader(),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: MedicalRecordSummaryCard(
                        icon: Icons.folder_open,
                        label: 'Total Records',
                        count: _allRecords.length,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: MedicalRecordSummaryCard(
                        icon: Icons.medication,
                        label: 'Prescriptions',
                        count: 2,
                        color: AppColors.secondaryTeal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: MedicalRecordSummaryCard(
                        icon: Icons.biotech,
                        label: 'Lab Reports',
                        count: 2,
                        color: AppColors.warningOrange,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: MedicalRecordSummaryCard(
                        icon: Icons.local_hospital,
                        label: 'Doctor Reports',
                        count: 2,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.prescriptionRecords);
                      },
                      icon: const Icon(Icons.medication),
                      label: const Text('View Prescriptions'),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.labReports);
                      },
                      icon: const Icon(Icons.biotech),
                      label: const Text('View Lab Reports'),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.doctorReports);
                      },
                      icon: const Icon(Icons.local_hospital),
                      label: const Text('View Doctor Reports'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: CustomTextField(
                  hint: 'Search medical records...',
                  prefixIcon: Icons.search,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              MedicalRecordsFilter(
                selectedFilter: _selectedFilter,
                onFilterChanged: (filter) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              if (_filteredRecords.isEmpty)
                const MedicalRecordEmptyState()
              else
                ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _filteredRecords.length,
                  itemBuilder: (context, index) {
                    final record = _filteredRecords[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: MedicalRecordCard(
                        icon: record.icon,
                        title: record.title,
                        doctorOrHospital: record.doctorOrHospital,
                        date: record.date,
                        type: record.type,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.medicalRecordDetails,
                            arguments: {
                              'title': record.title,
                              'hospital': record.doctorOrHospital,
                              'date': record.date,
                              'type': record.type,
                            },
                          );
                        },
                      ),
                    );
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
