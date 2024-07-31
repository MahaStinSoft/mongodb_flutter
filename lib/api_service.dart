import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = 'http://192.168.0.113:3000/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final extractedEmail =
            data.containsKey('email') ? data['email'] : email;

        if (data['success']) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', extractedEmail);
        }

        return {
          'success': data['success'],
          'email': extractedEmail,
        };
      } else {
        return {
          'success': false,
          'email': null,
        };
      }
    } catch (e) {
      print('Error during login: $e');
      return {
        'success': false,
        'email': null,
      };
    }
  }

  Future<Map<String, dynamic>> signup(
      String name, String mobileNumber, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'mobileNumber': mobileNumber,
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        // Return the error message if available
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'message': data['message'] ?? 'Signup failed',
        };
      }
    } catch (e) {
      print('Error during signup: $e');
      return {
        'success': false,
        'message': 'An error occurred during signup',
      };
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }

  Future<String?> getLoggedInEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }
}
