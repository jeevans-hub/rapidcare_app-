import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import '../core/config/api_config.dart';

class NotificationService {
  static String get baseUrl => ApiConfig.baseUrl;

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

  static Future<Map<String, dynamic>> getNotifications({String? type, bool? isRead}) {
    final params = <String, String>{};
    if (type != null && type.isNotEmpty) params['type'] = type;
    if (isRead != null) params['isRead'] = isRead.toString();
    final uri = Uri.parse('$baseUrl/notifications').replace(queryParameters: params);
    return _request(http.get(uri, headers: _headers), 'Failed to fetch notifications');
  }

  static Future<Map<String, dynamic>> getUnreadCount() => _request(
        http.get(Uri.parse('$baseUrl/notifications/unread-count'), headers: _headers),
        'Failed to fetch unread count',
      );

  static Future<Map<String, dynamic>> markAsRead(String id) => _request(
        http.patch(Uri.parse('$baseUrl/notifications/$id/read'), headers: _headers),
        'Failed to mark notification as read',
      );

  static Future<Map<String, dynamic>> markAllAsRead() => _request(
        http.patch(Uri.parse('$baseUrl/notifications/read-all'), headers: _headers),
        'Failed to mark notifications as read',
      );

  static Future<Map<String, dynamic>> deleteNotification(String id) => _request(
        http.delete(Uri.parse('$baseUrl/notifications/$id'), headers: _headers),
        'Failed to delete notification',
      );
}
