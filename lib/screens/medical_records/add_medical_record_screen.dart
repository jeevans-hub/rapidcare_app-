import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../services/medical_record_service.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/primary_button.dart';

class AddMedicalRecordScreen extends StatefulWidget {
  const AddMedicalRecordScreen({super.key});

  @override
  State<AddMedicalRecordScreen> createState() => _AddMedicalRecordScreenState();
}

class _AddMedicalRecordScreenState extends State<AddMedicalRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _doctorNameController = TextEditingController();
  final _hospitalNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _diagnosisTextController = TextEditingController();
  final _prescriptionTextController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedRecordType = 'general';
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  final List<Map<String, dynamic>> _recordTypes = [
    {
      'value': 'consultation',
      'label': 'Consultation',
      'icon': Icons.local_hospital,
    },
    {'value': 'lab_report', 'label': 'Lab Report', 'icon': Icons.biotech},
    {
      'value': 'prescription',
      'label': 'Prescription',
      'icon': Icons.medication,
    },
    {'value': 'vaccination', 'label': 'Vaccination', 'icon': Icons.vaccines},
    {'value': 'surgery', 'label': 'Surgery', 'icon': Icons.medical_services},
    {'value': 'allergy', 'label': 'Allergy', 'icon': Icons.warning},
    {'value': 'general', 'label': 'General', 'icon': Icons.description},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _doctorNameController.dispose();
    _hospitalNameController.dispose();
    _descriptionController.dispose();
    _diagnosisTextController.dispose();
    _prescriptionTextController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveMedicalRecord() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await MedicalRecordService.createMedicalRecord(
        title: _titleController.text.trim(),
        recordType: _selectedRecordType,
        recordDate: _selectedDate.toIso8601String().split('T')[0],
        doctorName: _doctorNameController.text.trim().isEmpty
            ? null
            : _doctorNameController.text.trim(),
        hospitalName: _hospitalNameController.text.trim().isEmpty
            ? null
            : _hospitalNameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        diagnosisText: _diagnosisTextController.text.trim().isEmpty
            ? null
            : _diagnosisTextController.text.trim(),
        prescriptionText: _prescriptionTextController.text.trim().isEmpty
            ? null
            : _prescriptionTextController.text.trim(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }

      if (result['success'] == true) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Medical record saved successfully'),
              backgroundColor: AppColors.successGreen,
            ),
          );
          Navigator.pop(context, true);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                result['message'] ?? 'Failed to save medical record',
              ),
              backgroundColor: AppColors.errorRed,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Unable to save the record. Check the server connection and try again.',
            ),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Medical Record')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.md),
                  const Text('Record Type', style: AppTextStyles.body),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: _recordTypes.map((type) {
                      final isSelected = _selectedRecordType == type['value'];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedRecordType = type['value'] as String;
                          });
                        },
                        borderRadius: BorderRadius.circular(AppRadius.medium),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryBlue
                                : AppColors.surfaceWhite,
                            borderRadius: BorderRadius.circular(
                              AppRadius.medium,
                            ),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryBlue
                                  : AppColors.backgroundLightGreyDark,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                type['icon'] as IconData,
                                size: 16,
                                color: isSelected
                                    ? AppColors.surfaceWhite
                                    : AppColors.textSecondaryGrey,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                type['label'] as String,
                                style: AppTextStyles.small.copyWith(
                                  color: isSelected
                                      ? AppColors.surfaceWhite
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  CustomTextField(
                    label: 'Title *',
                    hint: 'Enter record title',
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  InkWell(
                    onTap: _selectDate,
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.backgroundLightGreyDark,
                        ),
                        borderRadius: BorderRadius.circular(AppRadius.medium),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: AppColors.textSecondaryGrey,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Text(
                              'Record Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                              style: AppTextStyles.body,
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: AppColors.textSecondaryGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  CustomTextField(
                    label: 'Doctor Name',
                    hint: 'Enter doctor name (optional)',
                    controller: _doctorNameController,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  CustomTextField(
                    label: 'Hospital/Clinic Name',
                    hint: 'Enter hospital or clinic name (optional)',
                    controller: _hospitalNameController,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter description (optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextFormField(
                    controller: _diagnosisTextController,
                    decoration: const InputDecoration(
                      labelText: 'Diagnosis Text',
                      hintText: 'Enter diagnosis information (optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextFormField(
                    controller: _prescriptionTextController,
                    decoration: const InputDecoration(
                      labelText: 'Prescription Text',
                      hintText: 'Enter prescription information (optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextFormField(
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                      hintText: 'Enter additional notes (optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  if (_prescriptionTextController.text.trim().isNotEmpty ||
                      _diagnosisTextController.text.trim().isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.warningOrange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppRadius.medium),
                        border: Border.all(color: AppColors.warningOrange),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: AppColors.warningOrange,
                                size: 20,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  'Medical Disclaimer',
                                  style: AppTextStyles.body.copyWith(
                                    color: AppColors.warningOrange,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'This information is stored for reference only. Consult a qualified medical professional for medical advice.',
                            style: AppTextStyles.small.copyWith(
                              color: AppColors.textSecondaryGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: AppSpacing.lg),
                  PrimaryButton(
                    text: 'Save Record',
                    onPressed: _isLoading ? null : _saveMedicalRecord,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
