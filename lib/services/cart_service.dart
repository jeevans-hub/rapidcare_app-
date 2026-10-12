import '../core/config/api_config.dart';
import 'pharmacy_api.dart';

class CartService {
  static String get baseUrl => ApiConfig.baseUrl;
  static Future<Map<String, dynamic>> getCart() => PharmacyApi.request(
    'GET',
    '/cart',
    authenticated: true,
    log: '[Cart] Fetch',
  );
  static Future<Map<String, dynamic>> addToCart({
    required String medicineId,
    int quantity = 1,
  }) => PharmacyApi.request(
    'POST',
    '/cart/items',
    authenticated: true,
    body: {'medicineId': medicineId, 'quantity': quantity},
    log: '[Cart] Add',
  );
  static Future<Map<String, dynamic>> updateCartItem({
    required String medicineId,
    required int quantity,
  }) => PharmacyApi.request(
    'PATCH',
    '/cart/items/$medicineId',
    authenticated: true,
    body: {'quantity': quantity},
    log: '[Cart] Update',
  );
  static Future<Map<String, dynamic>> removeFromCart(String id) =>
      PharmacyApi.request(
        'DELETE',
        '/cart/items/$id',
        authenticated: true,
        log: '[Cart] Remove',
      );
  static Future<Map<String, dynamic>> clearCart() => PharmacyApi.request(
    'DELETE',
    '/cart',
    authenticated: true,
    log: '[Cart] Clear',
  );
}
