import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';

class RapidCareApp extends StatelessWidget {
  const RapidCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RapidCare',
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
