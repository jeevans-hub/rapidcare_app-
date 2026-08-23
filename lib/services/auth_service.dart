import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AuthService {
  // API base URL - platform-specific configuration
  // For Android emulator, use 10.0.2.2 to reach Windows host
  // For Windows/Web, use localhost
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:5000/api/v1';
    }
    return 'http://localhost:5000/api/v1';
  }
  
  // Store token in memory (for Phase 27)
  static String? _token;
  
  // Get current token
  static String? get token => _token;
  
  // Check if user is authenticated
  static bool get isAuthenticated => _token != null;
  
  // Register
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? dateOfBirth,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          if (phone != null && phone.isNotEmpty) 'phone': phone,
          if (dateOfBirth != null && dateOfBirth.isNotEmpty) 'dateOfBirth': dateOfBirth,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 && data['success'] == true) {
        _token = data['data']['token'];
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }
  
  // Login
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        _token = data['data']['token'];
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }
  
  // Get current user
  static Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      if (_token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.get(
        Uri.parse('$baseUrl/auth/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to get user',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }
  
  // Update profile
  static Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? phone,
    String? dateOfBirth,
  }) async {
    try {
      if (_token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.put(
        Uri.parse('$baseUrl/users/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({
          if (name?.isNotEmpty == true) 'name': name,
          if (phone?.isNotEmpty == true) 'phone': phone,
          if (dateOfBirth != null && dateOfBirth.isNotEmpty) 'dateOfBirth': dateOfBirth,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to update profile',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }
  
  // Logout
  static Future<Map<String, dynamic>> logout() async {
    try {
      // Clear local token
      _token = null;
      
      // Optional: Call backend logout endpoint
      // await http.post(
      //   Uri.parse('$baseUrl/auth/logout'),
      //   headers: {'Content-Type': 'application/json'},
      // );
      
      return {'success': true, 'message': 'Logged out successfully'};
    } catch (e) {
      // Even if backend call fails, clear local token
      _token = null;
      return {'success': true, 'message': 'Logged out successfully'};
    }
  }
}
