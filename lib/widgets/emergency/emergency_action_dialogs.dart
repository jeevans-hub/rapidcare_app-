import 'package:flutter/material.dart';

class EmergencyActionDialogs {
  const EmergencyActionDialogs._();

  static void showSosConfirmation(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('SOS Demo'),
        content: const Text(
          'This is a demo emergency feature. RapidCare does not contact '
          'emergency services automatically.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              showEmergencyOptions(context);
            },
            child: const Text('Show Emergency Options'),
          ),
        ],
      ),
    );
  }

  static void showEmergencyOptions(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Emergency Options'),
        content: const Text(
          'For immediate danger, contact your local emergency number. '
          'RapidCare does not place emergency calls from this demo.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  static void showAmbulanceInfo(BuildContext context) {
    _showInfo(
      context,
      'Call Ambulance',
      'No phone dialer is connected in this demo. Please call your local '
          'emergency number directly for urgent assistance.',
    );
  }

  static void showNearestHospitalInfo(BuildContext context) {
    _showInfo(
      context,
      'Nearest Hospital',
      'Location-based nearest hospital search is not implemented in this '
          'demo. Please use your phone maps or call local emergency services.',
    );
  }

  static void showPoliceInfo(BuildContext context) {
    _showInfo(
      context,
      'Police',
      'RapidCare cannot place a police call from this demo. For immediate '
          'danger, contact your local police or emergency number directly.',
    );
  }

  static void showFireInfo(BuildContext context) {
    _showInfo(
      context,
      'Fire Department',
      'RapidCare cannot place a fire department call from this demo. For a '
          'fire or immediate danger, contact your local emergency number directly.',
    );
  }

  static void showPoisonInfo(BuildContext context) {
    _showInfo(
      context,
      'Poison Control',
      'For poisoning emergencies, contact local emergency services or a '
          'qualified poison control center immediately.',
    );
  }

  static void showBloodBankInfo(BuildContext context) {
    _showInfo(
      context,
      'Blood Bank',
      'Blood bank lookup is not connected to a live service in this demo.',
    );
  }

  static void showContactInfo(BuildContext context, String action) {
    _showInfo(
      context,
      action,
      'This demo does not have phone or messaging integration enabled. '
          'Please use your device\'s contacts or phone app.',
    );
  }

  static void showDemoUnavailable(BuildContext context, String title, String message) {
    _showInfo(context, title, message);
  }

  static void _showInfo(BuildContext context, String title, String message) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
