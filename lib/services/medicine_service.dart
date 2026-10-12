import '../core/config/api_config.dart';
import 'pharmacy_api.dart';

class MedicineService {
  static String get baseUrl => ApiConfig.baseUrl;
  static Future<Map<String, dynamic>> getMedicines({
    String? search,
    String? category,
    bool? available,
    bool? requiresPrescription,
  }) => PharmacyApi.request(
    'GET',
    '/medicines',
    log: '[Pharmacy] Fetch medicines',
    query: {
      if (search != null && search.isNotEmpty) 'search': search,
      if (category != null && category.isNotEmpty) 'category': category,
      if (available != null) 'available': '$available',
      if (requiresPrescription != null)
        'requiresPrescription': '$requiresPrescription',
    },
  );
  static Future<Map<String, dynamic>> getMedicineById(String id) =>
      PharmacyApi.request(
        'GET',
        '/medicines/$id',
        log: '[Pharmacy] Medicine ID selected: $id',
      );
}
