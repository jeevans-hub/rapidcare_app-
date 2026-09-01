import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import '../core/config/api_config.dart';

class HealthMetricService {
  static String get baseUrl => ApiConfig.baseUrl;
  static Map<String, String> get _headers => {'Content-Type': 'application/json', if (AuthService.token != null) 'Authorization': 'Bearer ${AuthService.token}'};

  static Future<Map<String, dynamic>> _request(Future<http.Response> request, String fallback) async {
    try {
      if (AuthService.token == null) return {'success': false, 'message': 'Not authenticated'};
      final response = await request;
      final data = jsonDecode(response.body);
      if (data is Map<String, dynamic> && response.statusCode >= 200 && response.statusCode < 300 && data['success'] == true) return {'success': true, 'data': data['data']};
      return {'success': false, 'message': data is Map ? data['message']?.toString() ?? fallback : fallback};
    } catch (_) { return {'success': false, 'message': 'Unable to connect to the server'}; }
  }

  static Future<Map<String, dynamic>> getMetrics({String? metricType, int? limit}) { final params = <String, String>{if (metricType != null) 'metricType': metricType, if (limit != null) 'limit': limit.toString()}; final uri = Uri.parse('$baseUrl/health-metrics').replace(queryParameters: params); return _request(http.get(uri, headers: _headers), 'Failed to fetch health metrics'); }
  static Future<Map<String, dynamic>> getSummary() => _request(http.get(Uri.parse('$baseUrl/health-metrics/summary'), headers: _headers), 'Failed to fetch health summary');
  static Future<Map<String, dynamic>> createMetric({required String metricType, required String value, required String unit, DateTime? recordedAt, String? notes}) => _request(http.post(Uri.parse('$baseUrl/health-metrics'), headers: _headers, body: jsonEncode({'metricType': metricType, 'value': value, 'unit': unit, 'recordedAt': (recordedAt ?? DateTime.now()).toIso8601String(), 'notes': notes})), 'Failed to create health metric');
  static Future<Map<String, dynamic>> updateMetric(String id, Map<String, dynamic> updates) => _request(http.put(Uri.parse('$baseUrl/health-metrics/$id'), headers: _headers, body: jsonEncode(updates)), 'Failed to update health metric');
  static Future<Map<String, dynamic>> deleteMetric(String id) => _request(http.delete(Uri.parse('$baseUrl/health-metrics/$id'), headers: _headers), 'Failed to delete health metric');
}
