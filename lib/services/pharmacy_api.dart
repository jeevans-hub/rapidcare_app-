import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../core/config/api_config.dart';
import 'auth_service.dart';

class PharmacyApi {
  static Future<Map<String, dynamic>> request(
    String method,
    String path, {
    bool authenticated = false,
    Map<String, dynamic>? body,
    Map<String, String>? query,
    required String log,
  }) async {
    if (authenticated && AuthService.token == null) {
      return {'success': false, 'message': 'Please log in to continue.'};
    }
    try {
      if (kDebugMode) debugPrint(log);
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}$path',
      ).replace(queryParameters: query);
      final headers = {
        'Content-Type': 'application/json',
        if (authenticated) 'Authorization': 'Bearer ${AuthService.token}',
      };
      final http.Response response;
      switch (method) {
        case 'POST':
          response = await http
              .post(uri, headers: headers, body: jsonEncode(body ?? {}))
              .timeout(const Duration(seconds: 20));
        case 'PATCH':
          response = await http
              .patch(uri, headers: headers, body: jsonEncode(body ?? {}))
              .timeout(const Duration(seconds: 20));
        case 'DELETE':
          response = await http
              .delete(uri, headers: headers)
              .timeout(const Duration(seconds: 20));
        default:
          response = await http
              .get(uri, headers: headers)
              .timeout(const Duration(seconds: 20));
      }
      if (kDebugMode) {
        debugPrint('$log / response status: ${response.statusCode}');
      }
      if (response.statusCode == 401) {
        return {
          'success': false,
          'message': 'Session expired. Please log in again.',
        };
      }
      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) throw const FormatException();
      return {
        'success':
            response.statusCode >= 200 &&
            response.statusCode < 300 &&
            decoded['success'] == true,
        'data': decoded['data'],
        'message': decoded['message'] ?? 'Request failed. Please try again.',
      };
    } on FormatException {
      return {
        'success': false,
        'message': 'Unexpected server response. Please try again.',
      };
    } catch (_) {
      return {
        'success': false,
        'message': 'Unable to connect to the server. Please try again.',
      };
    }
  }
}
