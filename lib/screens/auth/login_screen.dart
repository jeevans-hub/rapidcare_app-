import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/section_title.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                title: 'Welcome Back',
              ),
              const SizedBox(height: 32),
              const CustomTextField(
                label: 'Email',
                hint: 'Enter your email',
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Password',
                hint: 'Enter your password',
                prefixIcon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Login',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                text: 'Create Account',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
