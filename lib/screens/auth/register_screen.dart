import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/section_title.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              const Icon(
                Icons.local_hospital,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 24),
              const SectionTitle(
                title: 'Create Account',
              ),
              const SizedBox(height: 32),
              const CustomTextField(
                label: 'Full Name',
                hint: 'Enter your full name',
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Email',
                hint: 'Enter your email',
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Phone',
                hint: 'Enter your phone number',
                prefixIcon: Icons.phone,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Password',
                hint: 'Enter your password',
                prefixIcon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Confirm Password',
                hint: 'Confirm your password',
                prefixIcon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Create Account',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Already have an account? Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
