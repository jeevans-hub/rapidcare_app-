import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';
import '../../widgets/pharmacy/pharmacy_widgets.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  bool _isPrescriptionUploaded = false;

  void _handleUpload() {
    setState(() {
      _isPrescriptionUploaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Prescription'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Upload Prescription',
                  subtitle: 'Upload your prescription to order prescribed medicines.',
                ),
                const SizedBox(height: AppSpacing.lg),
                PrescriptionUploadCard(
                  onUploadTap: _handleUpload,
                  onCameraTap: _handleUpload,
                ),
                const SizedBox(height: AppSpacing.lg),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      children: [
                        Icon(
                          _isPrescriptionUploaded
                              ? Icons.check_circle
                              : Icons.info_outline,
                          color: _isPrescriptionUploaded
                              ? AppColors.successGreen
                              : AppColors.warningOrange,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            _isPrescriptionUploaded
                                ? 'Prescription uploaded successfully'
                                : 'Prescription not uploaded',
                            style: AppTextStyles.body.copyWith(
                              color: _isPrescriptionUploaded
                                  ? AppColors.successGreen
                                  : AppColors.textSecondaryGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  text: 'Continue',
                  onPressed: _isPrescriptionUploaded
                      ? () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.pharmacyOrderConfirmation,
                          );
                        }
                      : null,
                  isEnabled: _isPrescriptionUploaded,
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
