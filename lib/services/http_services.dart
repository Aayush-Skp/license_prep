import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl = "https://question-server-orcin.vercel.app";
  // final String baseUrl = 'http://localhost:3000';

  Future<Map<String, dynamic>> get({required String endpointUrl}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpointUrl'));
      print(
        'Response body: ${response.body} from endpoint $baseUrl/$endpointUrl',
      );
      if (response.statusCode == 200) {
        // print("sucessfuly fetched");
        return json.decode(response.body);
      } else {
        return {'error': 'Request failed with status: ${response.statusCode}'};
      }
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}
