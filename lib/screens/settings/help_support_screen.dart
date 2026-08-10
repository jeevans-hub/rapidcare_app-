import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: SectionTitle(title: 'Frequently Asked Questions'),
              ),
              const SizedBox(height: AppSpacing.md),
              _FAQItem(
                question: 'How do I book an appointment?',
                answer:
                    'Go to the Dashboard, tap on "Book Appointment", select a doctor, choose a date and time, and confirm your booking.',
              ),
              _FAQItem(
                question: 'How do I order medicines?',
                answer:
                    'Navigate to Pharmacy from the Dashboard, browse medicines, add to cart, and proceed to checkout.',
              ),
              _FAQItem(
                question: 'How do I request an ambulance?',
                answer:
                    'Go to Emergency section from the Dashboard, tap on "Ambulance", fill in your location and emergency details.',
              ),
              _FAQItem(
                question: 'How do I update my profile?',
                answer:
                    'Go to Profile screen, tap on "Edit Profile", update your information, and save changes.',
              ),
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: SectionTitle(title: 'Contact Support'),
              ),
              const SizedBox(height: AppSpacing.md),
              _ContactOption(
                icon: Icons.phone,
                title: 'Call Support',
                subtitle: '+1 800 RAPIDCARE',
                onTap: () {},
              ),
              _ContactOption(
                icon: Icons.email,
                title: 'Email Support',
                subtitle: 'support@rapidcare.com',
                onTap: () {},
              ),
              _ContactOption(
                icon: Icons.chat,
                title: 'Live Chat',
                subtitle: 'Chat with our support team',
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQItem({
    required this.question,
    required this.answer,
  });

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.backgroundLightGreyDark),
      ),
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: AppTextStyles.body,
        ),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              widget.answer,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondaryGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _ContactOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(color: AppColors.backgroundLightGreyDark),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.medium),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryBlue,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondaryGrey,
            ),
          ],
        ),
      ),
    );
  }
}
