import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import '../core/config/api_config.dart';

class AppointmentService {
  static String get baseUrl => ApiConfig.baseUrl;

  // Create appointment
  static Future<Map<String, dynamic>> createAppointment({
    required String doctorId,
    required String appointmentDate,
    required String timeSlot,
    String? reason,
  }) async {
    if (!RegExp(r'^[0-9a-fA-F]{24}$').hasMatch(doctorId) ||
        DateTime.tryParse(appointmentDate) == null ||
        timeSlot.trim().isEmpty) {
      if (kDebugMode) {
        debugPrint('[Appointment] Booking failure: invalid selection');
      }
      return {
        'success': false,
        'message': 'Please select a doctor, date and time slot',
      };
    }
    try {
      if (AuthService.token == null) {
        if (kDebugMode) {
          debugPrint('[Appointment] Booking failure: not authenticated');
        }
        return {'success': false, 'message': 'Not authenticated'};
      }

      if (kDebugMode) {
        debugPrint('[Appointment] Doctor ID: $doctorId');
        debugPrint('[Appointment] Request sent');
      }
      final response = await http.post(
        Uri.parse('$baseUrl/appointments'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthService.token}',
        },
        body: jsonEncode({
          'doctorId': doctorId,
          'appointmentDate': appointmentDate,
          'timeSlot': timeSlot,
          if (reason != null && reason.isNotEmpty) 'reason': reason,
        }),
      );

      if (kDebugMode) {
        debugPrint('[Appointment] Response status: ${response.statusCode}');
      }
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        debugPrint(
          '[Appointment] Booking ${response.statusCode == 201 && data['success'] == true ? 'success' : 'failure'}',
        );
      }

      if (response.statusCode == 201 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to book appointment',
        };
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(
          '[Appointment] Booking failure: connection or response error',
        );
      }
      return {'success': false, 'message': 'Unable to connect to the server'};
    }
  }

  // Get user's appointments
  static Future<Map<String, dynamic>> getUserAppointments({
    String? status,
  }) async {
    try {
      if (AuthService.token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      // Build query parameters
      final queryParams = <String, String>{};
      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }

      final uri = Uri.parse(
        '$baseUrl/appointments',
      ).replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
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
          'message': data['message'] ?? 'Failed to fetch appointments',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Unable to connect to the server'};
    }
  }

  // Get appointment by ID
  static Future<Map<String, dynamic>> getAppointmentById(
    String appointmentId,
  ) async {
    try {
      if (AuthService.token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.get(
        Uri.parse('$baseUrl/appointments/$appointmentId'),
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
          'message': data['message'] ?? 'Failed to fetch appointment details',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Unable to connect to the server'};
    }
  }

  // Cancel appointment
  static Future<Map<String, dynamic>> cancelAppointment(
    String appointmentId,
  ) async {
    try {
      if (AuthService.token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.patch(
        Uri.parse('$baseUrl/appointments/$appointmentId/cancel'),
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
          'message': data['message'] ?? 'Failed to cancel appointment',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Unable to connect to the server'};
    }
  }

  // Reschedule appointment
  static Future<Map<String, dynamic>> rescheduleAppointment({
    required String appointmentId,
    required String appointmentDate,
    required String timeSlot,
  }) async {
    try {
      if (AuthService.token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.patch(
        Uri.parse('$baseUrl/appointments/$appointmentId/reschedule'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthService.token}',
        },
        body: jsonEncode({
          'appointmentDate': appointmentDate,
          'timeSlot': timeSlot,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to reschedule appointment',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Unable to connect to the server'};
    }
  }
}
