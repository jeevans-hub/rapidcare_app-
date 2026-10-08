import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rapidcare/core/theme/app_theme.dart';
import 'package:rapidcare/screens/home/home_screen.dart';
import 'package:rapidcare/core/routes/app_routes.dart';
import 'package:rapidcare/widgets/dashboard/quick_action_card.dart';
import 'package:rapidcare/widgets/dashboard/dashboard_health_monitoring_preview.dart';
import 'package:rapidcare/widgets/dashboard/dashboard_health_reports_preview.dart';
import 'package:rapidcare/widgets/dashboard/health_tip_card.dart';

void main() {
  for (final width in [320.0, 411.0]) {
    testWidgets('dashboard links remain tappable at ${width}px', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final routes = <String>[];
      final navigator = GlobalKey<NavigatorState>();
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigator,
          theme: AppTheme.lightTheme,
          home: const HomeScreen(),
          onGenerateRoute: (settings) {
            routes.add(settings.name!);
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => const Scaffold(body: Text('Destination')),
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      Future<void> checkTap(Finder finder, String route) async {
        await tester.ensureVisible(finder);
        await tester.pumpAndSettle();
        await tester.tap(finder);
        await tester.pumpAndSettle();
        expect(routes.last, route);
        expect(find.text('Destination'), findsOneWidget);
        navigator.currentState!.pop();
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }

      const actions = {
        'Book\nAppointment': AppRoutes.appointments,
        'Medical\nRecords': AppRoutes.medicalRecords,
        'Health\nMonitoring': AppRoutes.healthMonitoring,
        'Health\nReports': AppRoutes.healthReports,
        'Health &\nWellness': AppRoutes.healthHome,
        'Pharmacy': AppRoutes.pharmacyHome,
        'Doctors': AppRoutes.doctorList,
        'Health\nEducation': AppRoutes.healthEducation,
        'Emergency': AppRoutes.emergencyHome,
      };
      for (final action in actions.entries) {
        await checkTap(
          find.widgetWithText(QuickActionCard, action.key),
          action.value,
        );
      }
      await checkTap(find.text('View Appointments'), AppRoutes.appointments);
      await checkTap(
        find.byType(DashboardHealthMonitoringPreview),
        AppRoutes.healthMonitoring,
      );
      await checkTap(
        find.byType(DashboardHealthReportsPreview),
        AppRoutes.healthReports,
      );
      await checkTap(
        find.text('View All Services'),
        AppRoutes.healthcareServices,
      );
      for (final title in [
        'Sleep Better',
        'Stay Hydrated',
        'Exercise Daily',
        'Eat Healthy',
      ]) {
        final card = find.widgetWithText(HealthTipCard, title);
        await checkTap(
          find.descendant(of: card, matching: find.text('Read More')),
          AppRoutes.healthArticleDetails,
        );
      }
      expect(routes, hasLength(17));
    });
  }
  for (final width in [320.0, 360.0, 411.0, 800.0]) {
    for (final scale in [1.0, 1.5]) {
      testWidgets('dashboard fits ${width}px at text scale $scale', (
        tester,
      ) async {
        tester.view.physicalSize = Size(width, 900);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final errors = <FlutterErrorDetails>[];
        final originalHandler = FlutterError.onError;
        FlutterError.onError = errors.add;
        try {
          await tester.pumpWidget(
            MaterialApp(
              theme: AppTheme.lightTheme,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(scale)),
                child: child!,
              ),
              home: const HomeScreen(),
            ),
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(find.text('Nearby Hospitals'));
          await tester.pumpAndSettle();
        } finally {
          FlutterError.onError = originalHandler;
        }
        expect(
          errors.map((error) => error.exceptionAsString()).toList(),
          isEmpty,
        );
      });
    }
  }
}
