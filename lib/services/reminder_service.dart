import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ReminderService {
  static String get baseUrl => Platform.isAndroid
      ? 'http://10.0.2.2:5000/api/v1'
      : 'http://localhost:5000/api/v1';

  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (AuthService.token != null) 'Authorization': 'Bearer ${AuthService.token}',
      };

  static Future<Map<String, dynamic>> _request(Future<http.Response> request, String fallback) async {
    try {
      if (AuthService.token == null) return {'success': false, 'message': 'Not authenticated'};
      final response = await request;
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic> && response.statusCode >= 200 && response.statusCode < 300 && decoded['success'] == true) {
        return {'success': true, 'data': decoded['data']};
      }
      return {'success': false, 'message': decoded is Map ? decoded['message']?.toString() ?? fallback : fallback};
    } catch (_) {
      return {'success': false, 'message': 'Unable to connect to the server'};
    }
  }

  static Future<Map<String, dynamic>> getReminders({String? reminderType, String? status, bool? isActive}) {
    final params = <String, String>{};
    if (reminderType != null && reminderType.isNotEmpty) params['reminderType'] = reminderType;
    if (status != null && status.isNotEmpty) params['status'] = status;
    if (isActive != null) params['isActive'] = isActive.toString();
    final uri = Uri.parse('$baseUrl/reminders').replace(queryParameters: params);
    return _request(http.get(uri, headers: _headers), 'Failed to fetch reminders');
  }

  static Future<Map<String, dynamic>> createReminder({required String title, String? description, String reminderType = 'general', String? reminderDate, String? reminderTime, String repeat = 'none'}) => _request(
        http.post(Uri.parse('$baseUrl/reminders'), headers: _headers, body: jsonEncode({
          'title': title,
          'description': description,
          'reminderType': reminderType,
          'reminderDate': reminderDate,
          'reminderTime': reminderTime,
          'repeat': repeat,
        })),
        'Failed to create reminder',
      );

  static Future<Map<String, dynamic>> getReminder(String id) => _request(
        http.get(Uri.parse('$baseUrl/reminders/$id'), headers: _headers),
        'Failed to fetch reminder',
      );

  static Future<Map<String, dynamic>> updateReminder(String id, Map<String, dynamic> updates) => _request(
        http.put(Uri.parse('$baseUrl/reminders/$id'), headers: _headers, body: jsonEncode(updates)),
        'Failed to update reminder',
      );

  static Future<Map<String, dynamic>> completeReminder(String id) => _request(
        http.patch(Uri.parse('$baseUrl/reminders/$id/complete'), headers: _headers),
        'Failed to complete reminder',
      );

  static Future<Map<String, dynamic>> deleteReminder(String id) => _request(
        http.delete(Uri.parse('$baseUrl/reminders/$id'), headers: _headers),
        'Failed to delete reminder',
      );
}
