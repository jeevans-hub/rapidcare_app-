import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/medical_record_model.dart';
import '../../services/medical_record_service.dart';
import '../../widgets/medical_records/medical_records_widgets.dart';

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({super.key});

  @override
  State<MedicalRecordsScreen> createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> {
  String _selectedFilter = 'All';
  List<MedicalRecord> _allRecords = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMedicalRecords();
  }

  Future<void> _loadMedicalRecords() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      String? recordTypeFilter;
      if (_selectedFilter == 'Prescriptions') {
        recordTypeFilter = 'prescription';
      } else if (_selectedFilter == 'Lab Reports') {
        recordTypeFilter = 'lab_report';
      } else if (_selectedFilter == 'Doctor Reports') {
        recordTypeFilter = 'consultation';
      }

      final result = await MedicalRecordService.getMedicalRecords(
        recordType: recordTypeFilter,
        status: 'active',
      );

      setState(() {
        _isLoading = false;
        if (result['success'] == true) {
          final List<dynamic> recordsData = result['data']['medicalRecords'] ?? [];
          _allRecords = recordsData
              .map((json) => MedicalRecord.fromJson(json))
              .toList();
        } else {
          _errorMessage = result['message'] ?? 'Failed to load records';
          _allRecords = [];
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Unable to connect to the server';
        _allRecords = [];
      });
    }
  }

  List<MedicalRecord> get _filteredRecords {
    if (_selectedFilter == 'All') return _allRecords;
    return _allRecords.where((record) {
      switch (_selectedFilter) {
        case 'Prescriptions':
          return record.recordType == 'prescription';
        case 'Lab Reports':
          return record.recordType == 'lab_report';
        case 'Doctor Reports':
          return record.recordType == 'consultation';
        default:
          return true;
      }
    }).toList();
  }

  IconData _getIconForRecordType(String recordType) {
    switch (recordType) {
      case 'consultation':
        return Icons.local_hospital;
      case 'lab_report':
        return Icons.biotech;
      case 'prescription':
        return Icons.medication;
      case 'vaccination':
        return Icons.vaccines;
      case 'surgery':
        return Icons.medical_services;
      case 'allergy':
        return Icons.warning;
      default:
        return Icons.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Records'),
        actions: [
          IconButton(
            tooltip: 'Add Medical Record',
            icon: const Icon(Icons.add),
            onPressed: _openAddMedicalRecord,
          ),
        ],
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
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _openAddMedicalRecord,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Medical Record'),
                  ),
                ),
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
                        count: _allRecords.where((r) => r.recordType == 'prescription').length,
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
                        count: _allRecords.where((r) => r.recordType == 'lab_report').length,
                        color: AppColors.warningOrange,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: MedicalRecordSummaryCard(
                        icon: Icons.local_hospital,
                        label: 'Doctor Reports',
                        count: _allRecords.where((r) => r.recordType == 'consultation').length,
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
              MedicalRecordsFilter(
                selectedFilter: _selectedFilter,
                onFilterChanged: (filter) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                  _loadMedicalRecords();
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.xl),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      Icon(Icons.error_outline, size: 48, color: AppColors.errorRed),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ElevatedButton(
                        onPressed: _loadMedicalRecords,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              else if (_filteredRecords.isEmpty)
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
                        icon: _getIconForRecordType(record.recordType),
                        title: record.title,
                        doctorOrHospital: record.doctorName ?? record.hospitalName ?? 'Unknown',
                        date: record.getFormattedDate(),
                        type: record.getDisplayType(),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.medicalRecordDetails,
                            arguments: {
                              'recordId': record.id,
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
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddMedicalRecord,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _openAddMedicalRecord() async {
    final result = await Navigator.pushNamed(
      context,
      AppRoutes.addMedicalRecord,
    );
    if (result == true && mounted) {
      await _loadMedicalRecords();
    }
  }
}
