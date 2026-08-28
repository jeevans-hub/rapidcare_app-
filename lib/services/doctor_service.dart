import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class DoctorService {
  // API base URL - platform-specific configuration
  // For Android emulator, use 10.0.2.2 to reach Windows host
  // For Windows/Web, use localhost
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:5000/api/v1';
    }
    return 'http://localhost:5000/api/v1';
  }

  // Get all doctors with optional filtering
  static Future<Map<String, dynamic>> getDoctors({
    String? search,
    String? specialty,
    bool? available,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, String>{};
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (specialty != null && specialty.isNotEmpty && specialty != 'All') {
        queryParams['specialty'] = specialty;
      }
      if (available == true) {
        queryParams['available'] = 'true';
      }

      // Build URI with query parameters
      final uri = Uri.parse('$baseUrl/doctors').replace(queryParameters: queryParams);

      final response = await http.get(uri);

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to fetch doctors',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }

  // Get doctor by ID
  static Future<Map<String, dynamic>> getDoctorById(String doctorId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/doctors/$doctorId'),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to fetch doctor details',
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
