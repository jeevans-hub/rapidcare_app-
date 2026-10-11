import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:rapidcare/core/routes/app_router.dart';
import 'package:rapidcare/core/routes/app_routes.dart';
import 'package:rapidcare/screens/appointments/doctor_list_screen.dart';
import 'package:rapidcare/widgets/appointments/doctor_card.dart';
import 'package:rapidcare/widgets/appointments/doctor_rating_widget.dart';
import 'package:rapidcare/widgets/appointments/appointment_date_selector.dart';
import 'package:rapidcare/widgets/appointments/time_slot_card.dart';
import 'package:rapidcare/widgets/appointments/booking_success_dialog.dart';

final catalog =
    (jsonDecode(File('backend/src/seed/demoDoctors.json').readAsStringSync())
            as List)
        .asMap()
        .entries
        .map(
          (e) => <String, dynamic>{
            '_id': (e.key + 1).toRadixString(16).padLeft(24, '0'),
            'demoKey': e.value[0],
            'name': e.value[1],
            'specialty': e.value[2],
            'consultationFee': int.parse(e.value[3]),
            'isDemo': true,
            'isAvailable': true,
            'hospital': 'RapidCare Demo Clinic — Bengaluru',
            'contactEmail': e.value[7],
            'contactPhone': null,
            'consultationStart': e.value[5],
            'consultationEnd': e.value[6],
            'slotDurationMinutes': 30,
            'availableSlots': ['09:00 AM'],
            'availableDays': [
              'Monday',
              'Tuesday',
              'Wednesday',
              'Thursday',
              'Friday',
              'Saturday',
              'Sunday',
            ],
          },
        )
        .toList();

http.Response response(Object data) => http.Response(
  jsonEncode({'success': true, 'data': data}),
  200,
  headers: {'content-type': 'application/json; charset=utf-8'},
);

void main() {
  testWidgets(
    'demo booking dialog and confirmation explicitly label testing-only bookings',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: BookingSuccessDialog(isDemo: true)),
        ),
      );
      expect(
        find.text('Demo booking — testing only. No clinic was contacted.'),
        findsOneWidget,
      );
      final navigator = GlobalKey<NavigatorState>();
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigator,
          onGenerateRoute: AppRouter.generateRoute,
          home: const SizedBox(),
        ),
      );
      navigator.currentState!.pushNamed(
        AppRoutes.appointmentConfirmation,
        arguments: {
          'appointment': {
            '_id': '000000000000000000000001',
            'isDemo': true,
            'appointmentDay': '2030-01-14',
            'appointmentDate': '2030-01-13T18:30:00Z',
            'doctor': {'name': 'Demo Doctor'},
          },
        },
      );
      await tester.pumpAndSettle();
      expect(
        find.text('Demo booking — testing only. No clinic was contacted.'),
        findsOneWidget,
      );
      expect(find.text('14/1/2030'), findsOneWidget);
      expect(find.text('Demo only — no real visit'), findsOneWidget);
      expect(find.text('In-Person Visit'), findsNothing);
    },
  );
  testWidgets(
    'backend catalog search, all specialty filters, details and safe demo contacts',
    (tester) async {
      tester.view.physicalSize = const Size(1000, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final calls = <Uri>[];
      final client = MockClient((request) async {
        calls.add(request.url);
        if (request.url.path.endsWith('/doctors')) {
          final q = request.url.queryParameters;
          return response({
            'doctors': catalog
                .where(
                  (d) =>
                      (q['specialty'] == null ||
                          d['specialty'] == q['specialty']) &&
                      (q['search'] == null ||
                          '${d['name']} ${d['specialty']}'
                              .toLowerCase()
                              .contains(q['search']!.toLowerCase())),
                )
                .toList(),
            'specialties': catalog.map((d) => d['specialty']).toList(),
          });
        }
        return response({
          'doctor': catalog.singleWhere(
            (d) => request.url.path.endsWith(d['_id']),
          ),
        });
      });
      await http.runWithClient(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: const DoctorListScreen(),
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('Dr. Aanya Rao'), findsOneWidget);
        expect(find.byType(DoctorRatingWidget), findsNothing);
        await tester.enterText(find.byType(TextField), 'Meera');
        await tester.pumpAndSettle();
        expect(find.byType(DoctorCard), findsOneWidget);
        expect(find.text('Dr. Meera Iyer'), findsOneWidget);
        await tester.enterText(find.byType(TextField), 'Cardiology');
        await tester.pumpAndSettle();
        expect(find.text('Dr. Vikram Menon'), findsOneWidget);
        await tester.enterText(find.byType(TextField), '');
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.text('Cardiology').first);
        await tester.tap(find.text('Cardiology').first);
        await tester.pumpAndSettle();
        expect(calls.last.queryParameters['specialty'], 'Cardiology');
        expect(find.byType(DoctorCard), findsOneWidget);
        await tester.tap(find.text('Dr. Vikram Menon'));
        await tester.pumpAndSettle();
        expect(calls.last.path.endsWith(catalog[1]['_id']), isTrue);
        expect(
          find.textContaining('vikram.menon@rapidcare.example'),
          findsOneWidget,
        );
        expect(
          find.text('Phone contact unavailable — demo profile'),
          findsOneWidget,
        );
        expect(
          find.text('Demo doctor — appointments are for testing only.'),
          findsOneWidget,
        );
        expect(find.byType(DoctorRatingWidget), findsNothing);
        expect(tester.takeException(), isNull);
      }, () => client);
    },
  );

  testWidgets('list loading, empty and error states remain usable', (
    tester,
  ) async {
    final pending = Completer<http.Response>();
    var attempt = 0;
    final client = MockClient((request) {
      attempt++;
      if (attempt == 1) return pending.future;
      if (attempt == 2) {
        return Future.value(response({'doctors': [], 'specialties': []}));
      }
      return Future.value(
        http.Response(
          jsonEncode({'success': false, 'message': 'Catalog unavailable'}),
          503,
        ),
      );
    });
    await http.runWithClient(() async {
      await tester.pumpWidget(const MaterialApp(home: DoctorListScreen()));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      pending.complete(
        response({
          'doctors': catalog.take(1).toList(),
          'specialties': ['General Medicine'],
        }),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'missing');
      await tester.pumpAndSettle();
      expect(find.text('No doctors found'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'error');
      await tester.pumpAndSettle();
      expect(find.text('Catalog unavailable'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    }, () => client);
  });

  testWidgets(
    'booking shows only API slots and clears stale selection when date changes',
    (tester) async {
      tester.view.physicalSize = const Size(1000, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final dates = <String>[];
      final client = MockClient((request) async {
        expect(
          request.url.path,
          endsWith('/${catalog[0]['_id']}/availability'),
        );
        dates.add(request.url.queryParameters['date']!);
        return response({
          'slots': dates.length == 1 ? ['10:30 AM'] : <String>[],
        });
      });
      await http.runWithClient(() async {
        final navigator = GlobalKey<NavigatorState>();
        await tester.pumpWidget(
          MaterialApp(
            navigatorKey: navigator,
            onGenerateRoute: AppRouter.generateRoute,
            home: const SizedBox(),
          ),
        );
        navigator.currentState!.pushNamed(
          AppRoutes.bookAppointment,
          arguments: {
            'doctorId': catalog[0]['_id'],
            'doctorName': 'Dr. Aanya Rao',
            'availableSlots': ['09:00 AM'],
            'isDemo': true,
          },
        );
        await tester.pumpAndSettle();
        final dateCards = find.descendant(
          of: find.byType(AppointmentDateSelector),
          matching: find.byType(GestureDetector),
        );
        await tester.tap(dateCards.at(0));
        await tester.pumpAndSettle();
        expect(find.widgetWithText(TimeSlotCard, '09:00 AM'), findsNothing);
        await tester.tap(find.widgetWithText(TimeSlotCard, '10:30 AM'));
        await tester.tap(dateCards.at(1));
        await tester.pumpAndSettle();
        expect(dates[0], isNot(dates[1]));
        expect(find.byType(TimeSlotCard), findsNothing);
        expect(find.text('No available slots for this date.'), findsOneWidget);
        await tester.ensureVisible(
          find.widgetWithText(ElevatedButton, 'Book Appointment'),
        );
        await tester.tap(
          find.widgetWithText(ElevatedButton, 'Book Appointment'),
        );
        await tester.pumpAndSettle();
        expect(find.text('Please select date and time slot'), findsOneWidget);
        expect(dates.length, 2);
      }, () => client);
    },
  );
}
