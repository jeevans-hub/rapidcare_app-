import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/medical_record_model.dart';
import '../../services/medical_record_service.dart';
import '../../widgets/medical_records/medical_records_widgets.dart';

class PrescriptionRecordsScreen extends StatefulWidget {
  const PrescriptionRecordsScreen({super.key});

  @override
  State<PrescriptionRecordsScreen> createState() => _PrescriptionRecordsScreenState();
}

class _PrescriptionRecordsScreenState extends State<PrescriptionRecordsScreen> {
  List<MedicalRecord> _prescriptionRecords = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPrescriptionRecords();
  }

  Future<void> _loadPrescriptionRecords() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await MedicalRecordService.getMedicalRecords(
        recordType: 'prescription',
        status: 'active',
      );

      setState(() {
        _isLoading = false;
        if (result['success'] == true) {
          final List<dynamic> recordsData = result['data']['medicalRecords'] ?? [];
          _prescriptionRecords = recordsData
              .map((json) => MedicalRecord.fromJson(json))
              .toList();
        } else {
          _errorMessage = result['message'] ?? 'Failed to load prescriptions';
          _prescriptionRecords = [];
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Unable to connect to the server';
        _prescriptionRecords = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescriptions'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: MedicalRecordsHeader(
                  subtitle: 'Your prescription history',
                ),
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
                        style: AppTextStyles.body,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ElevatedButton(
                        onPressed: _loadPrescriptionRecords,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              else if (_prescriptionRecords.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      Icon(Icons.medication_outlined, size: 48, color: AppColors.textSecondaryGrey),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        'No prescription records found',
                        style: AppTextStyles.body,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSpacing.sm),
                      Text(
                        'Add a medical record with prescription type to get started',
                        style: AppTextStyles.caption,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                ..._prescriptionRecords.map((record) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.medicalRecordDetails,
                          arguments: {
                            'recordId': record.id,
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceWhite,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.backgroundLightGreyDark),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(AppSpacing.sm),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryTeal.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.medication,
                                    color: AppColors.secondaryTeal,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        record.title,
                                        style: AppTextStyles.body.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        record.getFormattedDate(),
                                        style: AppTextStyles.small.copyWith(
                                          color: AppColors.textSecondaryGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (record.doctorName != null) ...[
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                'Doctor: ${record.doctorName}',
                                style: AppTextStyles.small,
                              ),
                            ],
                            if (record.hospitalName != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                'Hospital: ${record.hospitalName}',
                                style: AppTextStyles.small,
                              ),
                            ],
                            if (record.prescriptionText != null && record.prescriptionText!.isNotEmpty) ...[
                              const SizedBox(height: AppSpacing.sm),
                              Container(
                                padding: const EdgeInsets.all(AppSpacing.sm),
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryTeal.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  record.prescriptionText!,
                                  style: AppTextStyles.small,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(
            context,
            AppRoutes.addMedicalRecord,
          );
          if (result == true) {
            _loadPrescriptionRecords();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
