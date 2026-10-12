import 'package:flutter/foundation.dart';
import '../core/config/api_config.dart';
import 'pharmacy_api.dart';

class OrderService {
  static String get baseUrl => ApiConfig.baseUrl;
  static Future<Map<String, dynamic>> placeOrder({
    String? deliveryAddress,
    String? notes,
    String? checkoutKey,
  }) async {
    final result = await PharmacyApi.request(
      'POST',
      '/orders',
      authenticated: true,
      body: {
        'deliveryAddress': ?deliveryAddress,
        'notes': ?notes,
        'checkoutKey': ?checkoutKey,
      },
      log: '[Checkout] Submit started',
    );
    if (kDebugMode && result['success'] == true) {
      debugPrint('[Order] Created ID: ${result['data']['order']['_id']}');
    }
    return result;
  }

  static Future<Map<String, dynamic>> getOrders({String? status}) =>
      PharmacyApi.request(
        'GET',
        '/orders',
        authenticated: true,
        query: {'status': ?status},
        log: '[Orders] History fetch',
      );
  static Future<Map<String, dynamic>> getOrderById(String id) =>
      PharmacyApi.request(
        'GET',
        '/orders/$id',
        authenticated: true,
        log: '[Orders] Detail fetch',
      );
  static Future<Map<String, dynamic>> cancelOrder(String id) =>
      PharmacyApi.request(
        'PATCH',
        '/orders/$id/cancel',
        authenticated: true,
        log: '[Orders] Cancel',
      );
}
