import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ActivityLogService {
  static String get baseUrl => Platform.isAndroid ? 'http://10.0.2.2:5000/api/v1' : 'http://localhost:5000/api/v1';
  static Map<String, String> get _headers => {'Content-Type': 'application/json', if (AuthService.token != null) 'Authorization': 'Bearer ${AuthService.token}'};
  static Future<Map<String, dynamic>> _request(Future<http.Response> request, String fallback) async { try { if (AuthService.token == null) return {'success': false, 'message': 'Not authenticated'}; final response = await request; final data = jsonDecode(response.body); if (data is Map<String, dynamic> && response.statusCode >= 200 && response.statusCode < 300 && data['success'] == true) return {'success': true, 'data': data['data']}; return {'success': false, 'message': data is Map ? data['message']?.toString() ?? fallback : fallback}; } catch (_) { return {'success': false, 'message': 'Unable to connect to the server'}; } }
  static Future<Map<String, dynamic>> getActivities() => _request(http.get(Uri.parse('$baseUrl/activity-logs'), headers: _headers), 'Failed to fetch activities');
  static Future<Map<String, dynamic>> getSummary() => _request(http.get(Uri.parse('$baseUrl/activity-logs/summary'), headers: _headers), 'Failed to fetch activity summary');
  static Future<Map<String, dynamic>> createActivity({required String activityType, required int durationMinutes, double? caloriesBurned, double? distance, int? steps, DateTime? activityDate, String? notes}) => _request(http.post(Uri.parse('$baseUrl/activity-logs'), headers: _headers, body: jsonEncode({'activityType': activityType, 'durationMinutes': durationMinutes, 'caloriesBurned': caloriesBurned, 'distance': distance, 'steps': steps, 'activityDate': (activityDate ?? DateTime.now()).toIso8601String(), 'notes': notes})), 'Failed to create activity');
  static Future<Map<String, dynamic>> updateActivity(String id, Map<String, dynamic> updates) => _request(http.put(Uri.parse('$baseUrl/activity-logs/$id'), headers: _headers, body: jsonEncode(updates)), 'Failed to update activity');
  static Future<Map<String, dynamic>> deleteActivity(String id) => _request(http.delete(Uri.parse('$baseUrl/activity-logs/$id'), headers: _headers), 'Failed to delete activity');
}
