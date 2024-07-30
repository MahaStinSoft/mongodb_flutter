// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ApiService {
//   static const String baseUrl = 'http://192.168.0.113:3000/api';

//   Future<Map<String, dynamic>> login(String email, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({'email': email, 'password': password}),
//     );

//     return json.decode(response.body);
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String localBaseUrl = 'http://localhost:3000/api';
  static const String remoteBaseUrl = 'http://192.168.0.113:3000/api';
  static const String baseUrl =
      remoteBaseUrl; // Change this to switch between URLs

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    return json.decode(response.body);
  }
}
