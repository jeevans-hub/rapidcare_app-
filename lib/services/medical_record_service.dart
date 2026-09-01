import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import '../core/config/api_config.dart';

class MedicalRecordService {
  static String get baseUrl => ApiConfig.baseUrl;

  // Create medical record
  static Future<Map<String, dynamic>> createMedicalRecord({
    required String title,
    required String recordType,
    required String recordDate,
    String? doctorName,
    String? hospitalName,
    String? description,
    String? diagnosisText,
    String? prescriptionText,
    String? notes,
  }) async {
    print('[DEBUG SERVICE] baseUrl: $baseUrl');
    print('[DEBUG SERVICE] Full POST URL: $baseUrl/medical-records');
    print('[DEBUG SERVICE] Token exists: ${AuthService.token != null}');
    
    try {
      if (AuthService.token == null) {
        print('[DEBUG SERVICE] Token is null, returning not authenticated');
        return {'success': false, 'message': 'Not authenticated'};
      }

      final requestBody = {
        'title': title,
        'recordType': recordType,
        'recordDate': recordDate,
        if (doctorName != null && doctorName.isNotEmpty) 'doctorName': doctorName,
        if (hospitalName != null && hospitalName.isNotEmpty) 'hospitalName': hospitalName,
        if (description != null && description.isNotEmpty) 'description': description,
        if (diagnosisText != null && diagnosisText.isNotEmpty) 'diagnosisText': diagnosisText,
        if (prescriptionText != null && prescriptionText.isNotEmpty) 'prescriptionText': prescriptionText,
        if (notes != null && notes.isNotEmpty) 'notes': notes,
      };
      print('[DEBUG SERVICE] Request body: $requestBody');

      final response = await http.post(
        Uri.parse('$baseUrl/medical-records'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthService.token}',
        },
        body: jsonEncode(requestBody),
      );

      print('[DEBUG SERVICE] Response statusCode: ${response.statusCode}');
      print('[DEBUG SERVICE] Response body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to save medical record',
        };
      }
    } catch (e) {
      print('[DEBUG SERVICE] Caught error: $e');
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }

  // Get user's medical records
  static Future<Map<String, dynamic>> getMedicalRecords({
    String? recordType,
    String? status,
    String? search,
  }) async {
    try {
      if (AuthService.token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      // Build query parameters
      final queryParams = <String, String>{};
      if (recordType != null && recordType.isNotEmpty) {
        queryParams['recordType'] = recordType;
      }
      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final uri = Uri.parse('$baseUrl/medical-records').replace(queryParameters: queryParams);

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
          'message': data['message'] ?? 'Failed to fetch medical records',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }

  // Get medical record by ID
  static Future<Map<String, dynamic>> getMedicalRecordById(String recordId) async {
    try {
      if (AuthService.token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.get(
        Uri.parse('$baseUrl/medical-records/$recordId'),
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
          'message': data['message'] ?? 'Failed to fetch medical record details',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }

  // Update medical record
  static Future<Map<String, dynamic>> updateMedicalRecord({
    required String recordId,
    String? title,
    String? recordType,
    String? doctorName,
    String? hospitalName,
    String? recordDate,
    String? description,
    String? diagnosisText,
    String? prescriptionText,
    String? notes,
  }) async {
    try {
      if (AuthService.token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.put(
        Uri.parse('$baseUrl/medical-records/$recordId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthService.token}',
        },
        body: jsonEncode({
          if (title != null && title.isNotEmpty) 'title': title,
          if (recordType != null && recordType.isNotEmpty) 'recordType': recordType,
          if (doctorName != null && doctorName.isNotEmpty) 'doctorName': doctorName,
          if (hospitalName != null && hospitalName.isNotEmpty) 'hospitalName': hospitalName,
          if (recordDate != null && recordDate.isNotEmpty) 'recordDate': recordDate,
          if (description != null && description.isNotEmpty) 'description': description,
          if (diagnosisText != null && diagnosisText.isNotEmpty) 'diagnosisText': diagnosisText,
          if (prescriptionText != null && prescriptionText.isNotEmpty) 'prescriptionText': prescriptionText,
          if (notes != null && notes.isNotEmpty) 'notes': notes,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to update medical record',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }

  // Archive medical record
  static Future<Map<String, dynamic>> archiveMedicalRecord(String recordId) async {
    try {
      if (AuthService.token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.patch(
        Uri.parse('$baseUrl/medical-records/$recordId/archive'),
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
          'message': data['message'] ?? 'Failed to archive medical record',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Unable to connect to the server',
      };
    }
  }

  // Delete medical record
  static Future<Map<String, dynamic>> deleteMedicalRecord(String recordId) async {
    try {
      if (AuthService.token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/medical-records/$recordId'),
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
          'message': data['message'] ?? 'Failed to delete medical record',
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
