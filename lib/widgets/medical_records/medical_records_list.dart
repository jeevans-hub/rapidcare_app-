import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'medical_record_card.dart';

class MedicalRecordsList extends StatelessWidget {
  final List<MedicalRecordItem> records;

  const MedicalRecordsList({
    super.key,
    required this.records,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: records.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final record = records[index];
        return MedicalRecordCard(
          icon: record.icon,
          title: record.title,
          doctorOrHospital: record.doctorOrHospital,
          date: record.date,
          type: record.type,
        );
      },
    );
  }
}

class MedicalRecordItem {
  final IconData icon;
  final String title;
  final String doctorOrHospital;
  final String date;
  final String type;

  MedicalRecordItem({
    required this.icon,
    required this.title,
    required this.doctorOrHospital,
    required this.date,
    required this.type,
  });
}
