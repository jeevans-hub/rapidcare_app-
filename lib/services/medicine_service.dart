import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class MedicineService {
  // API base URL - platform-specific configuration
  // For Android emulator, use 10.0.2.2 to reach Windows host
  // For Windows/Web, use localhost
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:5000/api/v1';
    }
    return 'http://localhost:5000/api/v1';
  }

  // Get all medicines with optional filters
  static Future<Map<String, dynamic>> getMedicines({
    String? search,
    String? category,
    bool? available,
    bool? requiresPrescription,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, String>{};
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }
      if (available != null) {
        queryParams['available'] = available.toString();
      }
      if (requiresPrescription != null) {
        queryParams['requiresPrescription'] = requiresPrescription.toString();
      }

      final uri = Uri.parse('$baseUrl/medicines').replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to fetch medicines',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }

  // Get medicine by ID
  static Future<Map<String, dynamic>> getMedicineById(String medicineId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/medicines/$medicineId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to fetch medicine details',
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
