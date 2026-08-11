import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_insurance/health_insurance_widgets.dart';

class InsuranceDocumentsScreen extends StatelessWidget {
  InsuranceDocumentsScreen({super.key});

  final List<Map<String, dynamic>> _documents = [
    {
      'documentName': 'Policy Document',
      'documentType': 'PDF',
      'date': '01 January 2026',
    },
    {
      'documentName': 'Insurance Card',
      'documentType': 'Image',
      'date': '01 January 2026',
    },
    {
      'documentName': 'Coverage Summary',
      'documentType': 'PDF',
      'date': '01 January 2026',
    },
    {
      'documentName': 'Claim Form',
      'documentType': 'PDF',
      'date': '15 January 2026',
    },
    {
      'documentName': 'Hospitalization Guidelines',
      'documentType': 'PDF',
      'date': '01 January 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance Documents'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'My Documents',
                  subtitle: 'Demo document records',
                ),
                const SizedBox(height: AppSpacing.lg),
                Card(
                  color: Colors.orange.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Colors.orange),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'These are demo document records only. No actual file storage or upload is available.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                    
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: AppSpacing.md,
                        crossAxisSpacing: AppSpacing.md,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: _documents.length,
                      itemBuilder: (context, index) {
                        final document = _documents[index];
                        return InsuranceDocumentCard(
                          documentName: document['documentName'],
                          documentType: document['documentType'],
                          date: document['date'],
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Demo document view - no actual file available.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
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
