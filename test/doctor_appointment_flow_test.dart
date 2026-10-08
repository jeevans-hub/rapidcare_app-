import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:rapidcare/core/routes/app_router.dart';
import 'package:rapidcare/core/routes/app_routes.dart';
import 'package:rapidcare/screens/appointments/doctor_list_screen.dart';
import 'package:rapidcare/services/auth_service.dart';
import 'package:rapidcare/services/appointment_service.dart';
import 'package:rapidcare/widgets/appointments/appointment_date_selector.dart';
import 'package:rapidcare/widgets/appointments/time_slot_card.dart';

const doctorId = '507f1f77bcf86cd799439011';
const doctor = <String, dynamic>{
  '_id': doctorId,
  'name': 'Dr. Robert Chen',
  'specialty': 'General Medicine',
  'qualification': 'MBBS',
  'hospital': 'Test Hospital',
  'experienceYears': 10,
  'rating': 4.8,
  'reviewCount': 100,
  'consultationFee': 500,
  'isAvailable': true,
  'availableSlots': ['09:00 AM', '10:00 AM'],
};

String calendarDay(DateTime date) =>
    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

void main() {
  tearDown(() async => AuthService.logout());

  test('doctor, booking and confirmation routes retain their arguments', () {
    for (final name in [
      AppRoutes.doctorDetails,
      AppRoutes.bookAppointment,
      AppRoutes.appointmentConfirmation,
    ]) {
      final settings = RouteSettings(
        name: name,
        arguments: {'doctorId': doctorId},
      );
      final route = AppRouter.generateRoute(settings);
      expect(route.settings, same(settings));
    }
  });

  testWidgets(
    'doctor card -> details API -> booking -> confirmation -> history',
    (tester) async {
      tester.view.physicalSize = const Size(1000, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final calls = <http.Request>[];
      Map<String, dynamic>? appointment;
      final client = MockClient((request) async {
        calls.add(request);
        Object data;
        var status = 200;
        if (request.url.path.endsWith('/auth/login')) {
          data = {
            'token': 'test-token',
            'user': {'name': 'Test'},
          };
        } else if (request.url.path.endsWith('/doctors/$doctorId')) {
          data = {'doctor': doctor};
        } else if (request.url.path.endsWith('/doctors')) {
          data = {
            'doctors': [doctor],
          };
        } else if (request.url.path.endsWith('/appointments')) {
          expect(request.headers['Authorization'], 'Bearer test-token');
          if (request.method == 'POST') {
            final body = jsonDecode(request.body) as Map<String, dynamic>;
            expect(body['doctorId'], doctorId);
            expect(body['timeSlot'], '09:00 AM');
            expect(body['appointmentDate'], calendarDay(DateTime.now()));
            appointment = {
              '_id': '507f1f77bcf86cd799439022',
              ...body,
              'appointmentDate': DateTime.parse(
                body['appointmentDate'] as String,
              ).toUtc().toIso8601String(),
              'doctor': doctor,
              'status': 'scheduled',
            };
            data = {'appointment': appointment};
            status = 201;
          } else {
            data = {
              'appointments': [appointment],
            };
          }
        } else {
          fail('Unexpected request: ${request.method} ${request.url.path}');
        }
        return http.Response(
          jsonEncode({'success': true, 'data': data}),
          status,
        );
      });

      await http.runWithClient(() async {
        await AuthService.login(
          email: 'test@example.test',
          password: 'test-password',
        );
        await tester.pumpWidget(
          MaterialApp(
            home: const DoctorListScreen(),
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('Dr. Robert Chen'));
        await tester.pumpAndSettle();
        expect(find.text('No doctor selected'), findsNothing);
        expect(
          calls.where((r) => r.url.path.endsWith('/doctors/$doctorId')),
          hasLength(1),
        );
        await tester.ensureVisible(
          find.widgetWithText(ElevatedButton, 'Book Appointment'),
        );
        await tester.tap(
          find.widgetWithText(ElevatedButton, 'Book Appointment'),
        );
        await tester.pumpAndSettle();
        expect(find.text('Dr. Robert Chen'), findsOneWidget);
        await tester.tap(
          find.descendant(
            of: find.byType(AppointmentDateSelector),
            matching: find.text(DateTime.now().day.toString()),
          ),
        );
        await tester.tap(find.widgetWithText(TimeSlotCard, '09:00 AM'));
        await tester.ensureVisible(
          find.widgetWithText(ElevatedButton, 'Book Appointment'),
        );
        await tester.tap(
          find.widgetWithText(ElevatedButton, 'Book Appointment'),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('View Appointment'));
        await tester.pumpAndSettle();
        expect(find.text('Appointment Confirmed!'), findsOneWidget);
        expect(find.text('507f1f77'), findsOneWidget);
        final today = DateTime.now();
        final displayDate = '${today.day}/${today.month}/${today.year}';
        expect(find.text(displayDate), findsOneWidget);
        await tester.ensureVisible(find.text('View My Appointments'));
        await tester.tap(find.text('View My Appointments'));
        await tester.pumpAndSettle();
        expect(find.text('Dr. Robert Chen'), findsOneWidget);
        expect(find.text(displayDate), findsOneWidget);
        expect(
          calls.where(
            (r) => r.method == 'POST' && r.url.path.endsWith('/appointments'),
          ),
          hasLength(1),
        );
        expect(
          calls.where(
            (r) => r.method == 'GET' && r.url.path.endsWith('/appointments'),
          ),
          hasLength(1),
        );
        expect(tester.takeException(), isNull);
      }, () => client);
    },
  );

  testWidgets('missing or incorrectly typed doctor arguments cannot book', (
    tester,
  ) async {
    for (final argument in [
      null,
      'wrong-type',
      {'doctorId': ''},
      {'doctorId': 123},
    ]) {
      final navigator = GlobalKey<NavigatorState>();
      await tester.pumpWidget(
        MaterialApp(
          key: UniqueKey(),
          navigatorKey: navigator,
          home: const SizedBox(),
          onGenerateRoute: AppRouter.generateRoute,
        ),
      );
      navigator.currentState!.pushNamed(
        AppRoutes.doctorDetails,
        arguments: argument,
      );
      await tester.pumpAndSettle();
      expect(find.text('No doctor selected'), findsOneWidget);
      expect(find.text('Select a Doctor'), findsOneWidget);
      expect(find.text('Book Appointment'), findsNothing);
      expect(tester.takeException(), isNull);
    }
  });

  test('invalid appointment selection never sends an HTTP request', () async {
    await http.runWithClient(
      () async {
        for (final input in [
          {'doctorId': '', 'date': '2030-01-01', 'slot': '09:00 AM'},
          {'doctorId': doctorId, 'date': 'invalid', 'slot': '09:00 AM'},
          {'doctorId': doctorId, 'date': '2030-01-01', 'slot': ''},
        ]) {
          final result = await AppointmentService.createAppointment(
            doctorId: input['doctorId']!,
            appointmentDate: input['date']!,
            timeSlot: input['slot']!,
          );
          expect(result['success'], false);
          expect(
            result['message'],
            'Please select a doctor, date and time slot',
          );
        }
      },
      () => MockClient(
        (_) async => throw StateError('Invalid booking reached HTTP'),
      ),
    );
  });
}
