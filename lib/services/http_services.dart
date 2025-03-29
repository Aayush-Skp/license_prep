import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  // final String baseUrl = "http://10.0.2.2:3000";
  final String baseUrl = 'http://localhost:3000';

  Future<Map<String, dynamic>> get({required String endpointUrl}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpointUrl'));
      print('$response of endpoint $baseUrl/$endpointUrl ');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'error': 'Request failed with status: ${response.statusCode}'};
      }
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}
