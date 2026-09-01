import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import '../core/config/api_config.dart';

class CartService {
  static String get baseUrl => ApiConfig.baseUrl;

  // Get user's cart
  static Future<Map<String, dynamic>> getCart() async {
    try {
      if (AuthService.token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.get(
        Uri.parse('$baseUrl/cart'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthService.token}',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to fetch cart',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }

  // Add item to cart
  static Future<Map<String, dynamic>> addToCart({
    required String medicineId,
    int quantity = 1,
  }) async {
    try {
      if (AuthService.token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.post(
        Uri.parse('$baseUrl/cart/items'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthService.token}',
        },
        body: jsonEncode({
          'medicineId': medicineId,
          'quantity': quantity,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to add item to cart',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }

  // Update cart item quantity
  static Future<Map<String, dynamic>> updateCartItem({
    required String medicineId,
    required int quantity,
  }) async {
    try {
      if (AuthService.token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.patch(
        Uri.parse('$baseUrl/cart/items/$medicineId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthService.token}',
        },
        body: jsonEncode({
          'quantity': quantity,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to update cart item',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }

  // Remove item from cart
  static Future<Map<String, dynamic>> removeFromCart(String medicineId) async {
    try {
      if (AuthService.token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/cart/items/$medicineId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthService.token}',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to remove item from cart',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }

  // Clear cart
  static Future<Map<String, dynamic>> clearCart() async {
    try {
      if (AuthService.token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/cart'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthService.token}',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to clear cart',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }
}
