import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class WaterIntakeCard extends StatefulWidget {
  final int current;
  final int target;

  const WaterIntakeCard({
    super.key,
    this.current = 5,
    this.target = 8,
  });

  @override
  State<WaterIntakeCard> createState() => _WaterIntakeCardState();
}

class _WaterIntakeCardState extends State<WaterIntakeCard> {
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.current;
  }

  @override
  Widget build(BuildContext context) {
    final progress = _current / widget.target;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.backgroundLightGreyDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.water_drop,
                color: AppColors.primaryBlue,
                size: 24,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Water Intake',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Text(
                '$_current',
                style: AppTextStyles.title.copyWith(
                  fontSize: 32,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '/ ${widget.target} glasses',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryGrey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: AppColors.backgroundLightGrey,
            valueColor: AlwaysStoppedAnimation<Color>(
              progress >= 1.0 ? AppColors.successGreen : AppColors.primaryBlue,
            ),
            borderRadius: BorderRadius.circular(AppRadius.small),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _current < widget.target
                  ? () {
                      setState(() {
                        _current++;
                      });
                    }
                  : null,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Glass'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryBlue,
                side: BorderSide(color: AppColors.primaryBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
