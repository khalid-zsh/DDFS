import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/app_constants.dart';

class ApiService {
  static Future<Map<String, dynamic>?> getRequest(String endpoint) async {
    try {
      final response = await http.get(Uri.parse("${AppConstants.apiUrl}/$endpoint"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("API Error: $e");
    }
    return null;
  }
}
