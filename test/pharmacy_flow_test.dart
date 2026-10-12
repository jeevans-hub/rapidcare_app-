import 'package:rapidcare/screens/pharmacy/pharmacy_cart_screen.dart';
import 'package:rapidcare/widgets/pharmacy/medicine_quantity_selector.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:rapidcare/core/routes/app_router.dart';
import 'package:rapidcare/core/routes/app_routes.dart';
import 'package:rapidcare/models/cart_model.dart';
import 'package:rapidcare/models/order_model.dart';
import 'package:rapidcare/screens/pharmacy/pharmacy_home_screen.dart';
import 'package:rapidcare/services/auth_service.dart';
import 'package:rapidcare/services/cart_service.dart';
import 'package:rapidcare/widgets/pharmacy/medicine_card.dart';

const medId = '507f1f77bcf86cd799439011';
const orderId = '507f1f77bcf86cd799439022';
const med = <String, dynamic>{
  '_id': medId,
  'name': 'QA Medicine',
  'category': 'General',
  'price': 10.0,
  'stock': 10,
  'isAvailable': true,
};
Map<String, dynamic> cartJson(int qty, {bool prescription = false}) => {
  '_id': 'cart',
  'items': [
    if (qty > 0)
      {
        'medicine': {...med, 'requiresPrescription': prescription},
        'quantity': qty,
        'priceAtAdd': 10.0,
      },
  ],
  'subtotal': qty * 10.0,
  'deliveryFee': qty > 0 ? 2.99 : 0,
  'total': qty > 0 ? qty * 10 + 2.99 : 0,
};
Map<String, dynamic> orderJson() => {
  '_id': orderId,
  'items': [
    {
      'medicine': med,
      'nameSnapshot': 'QA Medicine',
      'quantity': 1,
      'priceSnapshot': 10.0,
    },
  ],
  'subtotal': 10.0,
  'deliveryFee': 2.99,
  'totalAmount': 12.99,
  'status': 'placed',
  'createdAt': '2026-10-11T09:00:00.000Z',
};
http.Response ok(Object data, [int status = 200]) =>
    http.Response(jsonEncode({'success': true, 'data': data}), status);
Future<void> login() =>
    AuthService.login(email: 'qa@example.test', password: 'test-password');
void main() {
  responsiveTests();
  stateTests();
  tearDown(() async => AuthService.logout());
  test('pharmacy routes retain selected IDs and checkout arguments', () {
    for (final route in [
      AppRoutes.medicineDetails,
      AppRoutes.pharmacyCart,
      AppRoutes.pharmacyOrderConfirmation,
      AppRoutes.orderDetails,
      AppRoutes.orderHistory,
    ]) {
      final settings = RouteSettings(
        name: route,
        arguments: {'medicineId': medId, 'orderId': orderId},
      );
      expect(AppRouter.generateRoute(settings).settings, same(settings));
    }
  });
  test(
    'cart and order parsing handles populated, deleted and unpopulated medicines',
    () {
      for (final medicine in [med, medId, null]) {
        expect(
          CartItem.fromJson({
            'medicine': medicine,
            'quantity': 1,
            'priceAtAdd': 10,
          }).quantity,
          1,
        );
        expect(
          OrderItem.fromJson({
            'medicine': medicine,
            'nameSnapshot': 'Saved name',
            'quantity': 1,
          }).nameSnapshot,
          'Saved name',
        );
      }
    },
  );
  testWidgets(
    'catalog search/filter/reset, correct details, cart, explicit checkout, confirmation and order details',
    (tester) async {
      tester.view.physicalSize = const Size(800, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      int qty = 0, posts = 0;
      final calls = <http.Request>[];
      final client = MockClient((r) async {
        calls.add(r);
        final path = r.url.path;
        if (path.endsWith('/auth/login')) {
          return ok({
            'token': 'test-token',
            'user': {'name': 'QA'},
          });
        }
        if (path.endsWith('/medicines')) {
          return ok({
            'medicines': r.url.queryParameters['search'] == 'missing'
                ? []
                : [med],
            'categories': ['General', 'Vitamins'],
          });
        }
        if (path.endsWith('/medicines/$medId')) return ok({'medicine': med});
        expect(r.headers['Authorization'], 'Bearer test-token');
        if (path.endsWith('/cart/items')) {
          qty++;
          return ok({'cart': cartJson(qty)});
        }
        if (path.endsWith('/cart/items/$medId')) {
          qty = r.method == 'DELETE' ? 0 : jsonDecode(r.body)['quantity'];
          return ok({'cart': cartJson(qty)});
        }
        if (path.endsWith('/cart')) {
          if (r.method == 'DELETE') qty = 0;
          return ok({'cart': cartJson(qty)});
        }
        if (path.endsWith('/orders/$orderId')) {
          return ok({'order': orderJson()});
        }
        if (path.endsWith('/orders')) {
          if (r.method == 'POST') {
            posts++;
            expect(jsonDecode(r.body)['checkoutKey'], isNotEmpty);
            qty = 0;
            return ok({'order': orderJson()}, 201);
          }
          return ok({
            'orders': posts > 0 ? [orderJson()] : [],
          });
        }
        throw StateError(path);
      });
      await http.runWithClient(() async {
        await login();
        await tester.pumpWidget(
          MaterialApp(
            home: const PharmacyHomeScreen(),
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'missing');
        await tester.pump(const Duration(milliseconds: 350));
        await tester.pumpAndSettle();
        expect(find.text('No medicines available'), findsOneWidget);
        await tester.tap(find.text('Reset filters'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Vitamins'));
        await tester.pumpAndSettle();
        expect(
          calls
              .lastWhere((r) => r.url.path.endsWith('/medicines'))
              .url
              .queryParameters['category'],
          'Vitamins',
        );
        await tester.tap(find.text('Reset filters'));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(MedicineCard));
        await tester.pumpAndSettle();
        expect(find.text('Medicine was not selected'), findsNothing);
        await tester.ensureVisible(find.text('Add to Cart'));
        await tester.tap(find.text('Add to Cart'));
        await tester.pumpAndSettle();
        expect(qty, 1);
        Navigator.of(
          tester.element(find.text('Medicine Details')),
        ).pushNamed(AppRoutes.pharmacyCart);
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.text('Proceed to Checkout'));
        await tester.tap(find.text('Proceed to Checkout'));
        await tester.pumpAndSettle();
        expect(posts, 0);
        await tester.tap(find.text('Place Demo Order'));
        await tester.tap(find.text('Place Demo Order'));
        await tester.pumpAndSettle();
        expect(posts, 1);
        expect(qty, 0);
        expect(find.text('Order Placed Successfully!'), findsOneWidget);
        await tester.ensureVisible(find.text('View Order Details'));
        await tester.tap(find.text('View Order Details'));
        await tester.pumpAndSettle();
        expect(calls.any((r) => r.url.path.endsWith('/orders/$orderId')), true);
        expect(find.text('QA Medicine'), findsOneWidget);
        expect(tester.takeException(), isNull);
      }, () => client);
    },
  );
  testWidgets('prescription checkout is blocked before submission', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: AppRouter.generateRoute,
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.pharmacyOrderConfirmation,
              arguments: {
                'cart': Cart.fromJson(cartJson(1, prescription: true)),
              },
            ),
            child: const Text('Checkout'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Checkout'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Prescription verification is unavailable'),
      findsOneWidget,
    );
    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Place Demo Order'),
    );
    expect(button.onPressed, isNull);
  });
  test(
    'expired session and invalid server responses are displayed safely',
    () async {
      await http.runWithClient(
        () async {
          await login();
          expect(
            (await CartService.getCart())['message'],
            contains('Session expired'),
          );
        },
        () => MockClient(
          (r) async => r.url.path.endsWith('/auth/login')
              ? ok({'token': 'test-token', 'user': {}})
              : http.Response('Unauthorized', 401),
        ),
      );
      await http.runWithClient(
        () async {
          expect(
            (await CartService.getCart())['message'],
            contains('Unexpected server response'),
          );
        },
        () => MockClient((r) async => http.Response('<html>error</html>', 502)),
      );
    },
  );
  testWidgets('catalog loading, failure and retry work at narrow width', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    var fail = true;
    await http.runWithClient(
      () async {
        await tester.pumpWidget(const MaterialApp(home: PharmacyHomeScreen()));
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        await tester.pumpAndSettle();
        expect(find.text('Retry'), findsOneWidget);
        fail = false;
        await tester.tap(find.text('Retry'));
        await tester.pumpAndSettle();
        expect(find.text('QA Medicine'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
      () => MockClient(
        (r) async => fail
            ? http.Response(
                jsonEncode({'success': false, 'message': 'Unavailable'}),
                503,
              )
            : ok({
                'medicines': [med],
                'categories': ['General'],
              }),
      ),
    );
  });
}

void stateTests() {
  testWidgets(
    'cart quantity follows accepted responses; rejected changes stay unchanged; remove and clear work',
    (tester) async {
      tester.view.physicalSize = const Size(320, 1200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      var qty = 1;
      var reject = true;
      await http.runWithClient(
        () async {
          await login();
          await tester.pumpWidget(
            const MaterialApp(home: PharmacyCartScreen()),
          );
          await tester.pumpAndSettle();
          await tester.tap(find.byIcon(Icons.add));
          await tester.pumpAndSettle();
          expect(
            tester
                .widget<MedicineQuantitySelector>(
                  find.byType(MedicineQuantitySelector),
                )
                .initialQuantity,
            1,
          );
          expect(find.text('Insufficient stock'), findsOneWidget);
          reject = false;
          await tester.tap(find.byIcon(Icons.add));
          await tester.pumpAndSettle();
          expect(
            tester
                .widget<MedicineQuantitySelector>(
                  find.byType(MedicineQuantitySelector),
                )
                .initialQuantity,
            2,
          );
          await tester.tap(find.byIcon(Icons.remove));
          await tester.pumpAndSettle();
          expect(qty, 1);
          await tester.tap(find.byIcon(Icons.delete_outline));
          await tester.pumpAndSettle();
          expect(find.text('Your cart is empty'), findsOneWidget);
          qty = 1;
          await tester.pumpWidget(const SizedBox());
          await tester.pumpWidget(
            const MaterialApp(home: PharmacyCartScreen()),
          );
          await tester.pumpAndSettle();
          await tester.tap(find.text('Clear cart'));
          await tester.pumpAndSettle();
          expect(find.text('Your cart is empty'), findsOneWidget);
          expect(tester.takeException(), isNull);
        },
        () => MockClient((r) async {
          if (r.url.path.endsWith('/auth/login')) {
            return ok({'token': 'test-token', 'user': {}});
          }
          if (r.method == 'PATCH') {
            if (reject) {
              return http.Response(
                jsonEncode({'success': false, 'message': 'Insufficient stock'}),
                400,
              );
            }
            qty = jsonDecode(r.body)['quantity'];
          }
          if (r.method == 'DELETE') qty = 0;
          return ok({'cart': cartJson(qty)});
        }),
      );
    },
  );
  testWidgets(
    'missing order and checkout arguments terminate loading with clear errors',
    (tester) async {
      for (final name in [
        AppRoutes.orderDetails,
        AppRoutes.pharmacyOrderConfirmation,
      ]) {
        await tester.pumpWidget(
          MaterialApp(
            key: ValueKey(name),
            initialRoute: name,
            onGenerateInitialRoutes: (route) => [
              AppRouter.generateRoute(RouteSettings(name: route)),
            ],
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(
          find.textContaining(
            name == AppRoutes.orderDetails
                ? 'Order was not selected'
                : 'Your cart is empty',
          ),
          findsOneWidget,
        );
      }
    },
  );
}

void responsiveTests() {
  testWidgets(
    'confirmation returns to dashboard instead of an old splash route',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          onGenerateInitialRoutes: (_) => [
            AppRouter.generateRoute(
              RouteSettings(
                name: AppRoutes.pharmacyOrderConfirmation,
                arguments: {'order': Order.fromJson(orderJson())},
              ),
            ),
          ],
          onGenerateRoute: (settings) => settings.name == AppRoutes.home
              ? MaterialPageRoute(
                  builder: (_) =>
                      const Scaffold(body: Text('Dashboard destination')),
                )
              : AppRouter.generateRoute(settings),
        ),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Back to Home'));
      await tester.tap(find.text('Back to Home'));
      await tester.pumpAndSettle();
      expect(find.text('Dashboard destination'), findsOneWidget);
      expect(find.text('Order Placed Successfully!'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
  for (final width in [320.0, 360.0, 393.0, 412.0]) {
    for (final scale in [1.0, 2.0]) {
      testWidgets('cart fits ${width}px at text scale $scale', (tester) async {
        tester.view.physicalSize = Size(width, 1000);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await http.runWithClient(
          () async {
            await login();
            await tester.pumpWidget(
              MaterialApp(
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.linear(scale)),
                  child: child!,
                ),
                home: const PharmacyCartScreen(),
              ),
            );
            await tester.pumpAndSettle();
            expect(tester.takeException(), isNull);
            await tester.ensureVisible(find.text('Proceed to Checkout'));
            await tester.pumpAndSettle();
            expect(tester.takeException(), isNull);
            expect(find.text('Proceed to Checkout'), findsOneWidget);
          },
          () => MockClient(
            (r) async => r.url.path.endsWith('/auth/login')
                ? ok({'token': 'test-token', 'user': {}})
                : ok({
                    'cart': {
                      'items': [
                        {
                          'medicine': {
                            ...med,
                            'name':
                                'Long medicine name for responsive cart verification',
                          },
                          'quantity': 100,
                          'priceAtAdd': 1234.56,
                        },
                      ],
                      'subtotal': 123456.0,
                      'deliveryFee': 2.99,
                      'total': 123458.99,
                    },
                  }),
          ),
        );
      });
    }
  }
  testWidgets(
    'missing and malformed pharmacy IDs offer recovery without API calls',
    (tester) async {
      for (final route in [AppRoutes.medicineDetails, AppRoutes.orderDetails]) {
        for (final args in [
          null,
          'wrong type',
          {'medicineId': 123, 'orderId': 123},
        ]) {
          await tester.pumpWidget(
            MaterialApp(
              key: UniqueKey(),
              onGenerateInitialRoutes: (_) => [
                AppRouter.generateRoute(
                  RouteSettings(name: route, arguments: args),
                ),
              ],
              onGenerateRoute: AppRouter.generateRoute,
            ),
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          expect(
            find.text(
              route == AppRoutes.medicineDetails
                  ? 'Browse medicines'
                  : 'View order history',
            ),
            findsOneWidget,
          );
        }
      }
    },
  );
  testWidgets(
    'confirmation accepts the actual created order without placing another order',
    (tester) async {
      await http.runWithClient(
        () async {
          await tester.pumpWidget(
            MaterialApp(
              onGenerateInitialRoutes: (_) => [
                AppRouter.generateRoute(
                  RouteSettings(
                    name: AppRoutes.pharmacyOrderConfirmation,
                    arguments: {'order': Order.fromJson(orderJson())},
                  ),
                ),
              ],
              onGenerateRoute: AppRouter.generateRoute,
            ),
          );
          await tester.pumpAndSettle();
          expect(find.text('Order Placed Successfully!'), findsOneWidget);
          expect(find.text('QA Medicine x 1'), findsOneWidget);
          expect(tester.takeException(), isNull);
        },
        () => MockClient(
          (r) async =>
              throw StateError('Confirmation must not submit a new order'),
        ),
      );
    },
  );
}
