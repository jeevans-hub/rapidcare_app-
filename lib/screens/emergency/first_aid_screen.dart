import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';

class FirstAidScreen extends StatefulWidget {
  const FirstAidScreen({super.key});

  @override
  State<FirstAidScreen> createState() => _FirstAidScreenState();
}

class _FirstAidScreenState extends State<FirstAidScreen> {
  final Map<String, bool> _expandedCategories = {
    'Heart Attack': false,
    'CPR': false,
    'Burns': false,
    'Fractures': false,
    'Bleeding': false,
    'Snake Bite': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Aid Guide'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'First Aid Instructions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Quick medical guidance for emergencies',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildExpandableCategory(
                title: 'Heart Attack',
                icon: Icons.favorite,
                instructions: '''
1. Call emergency services immediately
2. Have the person sit down and rest
3. Loosen tight clothing
4. If aspirin is available and not allergic, have them chew one
5. Monitor breathing and pulse
6. Be prepared to perform CPR if necessary
                '''.trim(),
              ),
              _buildExpandableCategory(
                title: 'CPR',
                icon: Icons.health_and_safety,
                instructions: '''
1. Check for responsiveness
2. Call for help
3. Open airway
4. Check breathing
5. Start chest compressions (30 compressions)
6. Give rescue breaths (2 breaths)
7. Repeat cycle until help arrives
                '''.trim(),
              ),
              _buildExpandableCategory(
                title: 'Burns',
                icon: Icons.local_fire_department,
                instructions: '''
1. Cool the burn with running water for 10-20 minutes
2. Remove jewelry and tight clothing
3. Cover with sterile non-stick bandage
4. Do not apply ice, butter, or ointments
5. Seek medical attention for severe burns
                '''.trim(),
              ),
              _buildExpandableCategory(
                title: 'Fractures',
                icon: Icons.accessibility,
                instructions: '''
1. Immobilize the injured area
2. Apply ice to reduce swelling
3. Elevate if possible
4. Do not attempt to realign the bone
5. Seek immediate medical attention
                '''.trim(),
              ),
              _buildExpandableCategory(
                title: 'Bleeding',
                icon: Icons.water_drop,
                instructions: '''
1. Apply direct pressure with clean cloth
2. Elevate the injured area above heart
3. Maintain pressure until bleeding stops
4. If severe, call emergency services
5. Do not remove blood-soaked bandages
                '''.trim(),
              ),
              _buildExpandableCategory(
                title: 'Snake Bite',
                icon: Icons.pets,
                instructions: '''
1. Call emergency services immediately
2. Keep the person calm and still
3. Immobilize the bitten limb
4. Do not apply tourniquet
5. Do not cut or suck the wound
6. Note snake appearance if possible
                '''.trim(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableCategory({
    required String title,
    required IconData icon,
    required String instructions,
  }) {
    final isExpanded = _expandedCategories[title] ?? false;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _expandedCategories[title] = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              instructions,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
