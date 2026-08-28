import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/medical_record_model.dart';
import '../../services/medical_record_service.dart';
import '../../widgets/section_title.dart';

class MedicalRecordDetailsScreen extends StatefulWidget {
  const MedicalRecordDetailsScreen({super.key});

  @override
  State<MedicalRecordDetailsScreen> createState() => _MedicalRecordDetailsScreenState();
}

class _MedicalRecordDetailsScreenState extends State<MedicalRecordDetailsScreen> {
  MedicalRecord? _record;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadRecord();
  }

  Future<void> _loadRecord() async {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final recordId = arguments?['recordId']?.toString();

    if (recordId == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Record ID not provided';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await MedicalRecordService.getMedicalRecordById(recordId);

      setState(() {
        _isLoading = false;
        if (result['success'] == true) {
          final recordData = result['data']['medicalRecord'];
          _record = MedicalRecord.fromJson(recordData);
        } else {
          _errorMessage = result['message'] ?? 'Failed to load record';
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Unable to connect to the server';
      });
    }
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

  Future<void> _archiveRecord() async {
    if (_record == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Archive Record'),
        content: const Text('Are you sure you want to archive this medical record?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Archive'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final result = await MedicalRecordService.archiveMedicalRecord(_record!.id);

      if (result['success'] == true) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Record archived successfully'),
              backgroundColor: AppColors.successGreen,
            ),
          );
          Navigator.pop(context, true);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'Failed to archive record'),
              backgroundColor: AppColors.errorRed,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to connect to the server'),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    }
  }

  Future<void> _deleteRecord() async {
    if (_record == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Record'),
        content: const Text('Are you sure you want to delete this medical record?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.errorRed),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final result = await MedicalRecordService.deleteMedicalRecord(_record!.id);

      if (result['success'] == true) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Record deleted successfully'),
              backgroundColor: AppColors.successGreen,
            ),
          );
          Navigator.pop(context, true);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'Failed to delete record'),
              backgroundColor: AppColors.errorRed,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to connect to the server'),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Medical Record'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null || _record == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Medical Record'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: AppColors.errorRed),
                const SizedBox(height: AppSpacing.md),
                Text(
                  _errorMessage ?? 'Record not found',
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final record = _record!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Record'),
        actions: [
          IconButton(
            icon: const Icon(Icons.archive),
            onPressed: _archiveRecord,
            tooltip: 'Archive',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteRecord,
            tooltip: 'Delete',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getIconForRecordType(record.recordType),
                    size: 50,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Text(
                  record.title,
                  style: AppTextStyles.headline,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Text(
                  record.hospitalName ?? record.doctorName ?? 'Unknown',
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Text(
                  record.getFormattedDate(),
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warningOrange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.small),
                  ),
                  child: Text(
                    record.getDisplayType(),
                    style: AppTextStyles.caption,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              if (record.doctorName != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: _DetailRow(label: 'Doctor', value: record.doctorName!),
                ),
              if (record.doctorName != null) const SizedBox(height: AppSpacing.sm),
              if (record.hospitalName != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: _DetailRow(label: 'Hospital', value: record.hospitalName!),
                ),
              if (record.hospitalName != null) const SizedBox(height: AppSpacing.sm),
              if (record.description != null && record.description!.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.lg),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: SectionTitle(title: 'Description'),
                ),
                const SizedBox(height: AppSpacing.md),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Text(
                    record.description!,
                    style: AppTextStyles.body,
                  ),
                ),
              ],
              if (record.diagnosisText != null && record.diagnosisText!.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: SectionTitle(title: 'Diagnosis'),
                ),
                const SizedBox(height: AppSpacing.md),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.warningOrange.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                      border: Border.all(color: AppColors.warningOrange.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.diagnosisText!,
                          style: AppTextStyles.body,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'This information is stored for reference only. Consult a qualified medical professional for medical advice.',
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.textSecondaryGrey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (record.prescriptionText != null && record.prescriptionText!.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: SectionTitle(title: 'Prescription'),
                ),
                const SizedBox(height: AppSpacing.md),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryTeal.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                      border: Border.all(color: AppColors.secondaryTeal.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.prescriptionText!,
                          style: AppTextStyles.body,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'This information is stored for reference only. Consult a qualified medical professional for medical advice.',
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.textSecondaryGrey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (record.notes != null && record.notes!.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: SectionTitle(title: 'Notes'),
                ),
                const SizedBox(height: AppSpacing.md),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Text(
                    record.notes!,
                    style: AppTextStyles.body,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondaryGrey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.body,
          ),
        ),
      ],
    );
  }
}
