import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/primary_button.dart';

class AmbulanceRequestScreen extends StatefulWidget {
  const AmbulanceRequestScreen({super.key});

  @override
  State<AmbulanceRequestScreen> createState() => _AmbulanceRequestScreenState();
}

class _AmbulanceRequestScreenState extends State<AmbulanceRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  String _emergencyType = 'Medical Emergency';

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Ambulance'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: _nameController,
                  label: 'Patient Name',
                  hint: 'Enter patient name',
                  prefixIcon: Icons.person,
                ),
                const SizedBox(height: AppSpacing.md),
                CustomTextField(
                  controller: _locationController,
                  label: 'Location',
                  hint: 'Enter location or use GPS',
                  prefixIcon: Icons.location_on,
                ),
                const SizedBox(height: AppSpacing.md),
                DropdownButtonFormField<String>(
                  initialValue: _emergencyType,
                  decoration: const InputDecoration(
                    labelText: 'Emergency Type',
                    prefixIcon: Icon(Icons.emergency),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Medical Emergency',
                      child: Text('Medical Emergency'),
                    ),
                    DropdownMenuItem(
                      value: 'Accident',
                      child: Text('Accident'),
                    ),
                    DropdownMenuItem(
                      value: 'Cardiac Emergency',
                      child: Text('Cardiac Emergency'),
                    ),
                    DropdownMenuItem(
                      value: 'Respiratory Emergency',
                      child: Text('Respiratory Emergency'),
                    ),
                    DropdownMenuItem(
                      value: 'Other',
                      child: Text('Other'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _emergencyType = value!;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                CustomTextField(
                  controller: _notesController,
                  label: 'Additional Notes',
                  hint: 'Describe the situation',
                  prefixIcon: Icons.note,
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  text: 'Request Ambulance',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showRequestConfirmation();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRequestConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ambulance Requested'),
        content: const Text('Your ambulance request has been submitted. Help is on the way.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
