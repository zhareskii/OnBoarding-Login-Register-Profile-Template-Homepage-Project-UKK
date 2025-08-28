import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class ApiService {
  static const String baseUrl = 'http://192.168.0.238/ukk-backend/web/api';
  
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  static void _log(String message) {
    developer.log(message, name: 'ApiService');
  }
  
  static Future<Map<String, dynamic>> loginUser(String username, String password) async {
    try {
      _log('Calling POST: $baseUrl/auth/login');
      _log('Login data: username=$username');
      
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: headers,
        body: json.encode({
          'username': username,
          'password': password,
        }),
      ).timeout(Duration(seconds: 10));
      
      _log('Login Response Status: ${response.statusCode}');
      _log('Login Response Body: ${response.body}');
      
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      
      if (response.statusCode == 200) {
        return responseData;
      } else {
        return <String, dynamic>{
          'status': 'error',
          'message': responseData['message'] ?? 'Login gagal'
        };
      }
    } catch (e) {
      _log('Error in loginUser: $e');
      return <String, dynamic>{
        'status': 'error',
        'message': 'Network error: ${e.toString()}'
      };
    }
  }
  
  static Future<Map<String, dynamic>> getUsers() async {
    try {
      _log('Calling GET: $baseUrl/users');
      
      final response = await http.get(
        Uri.parse('$baseUrl/users'),
        headers: headers,
      ).timeout(Duration(seconds: 10));
      
      _log('GET Users Response Status: ${response.statusCode}');
      _log('GET Users Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        
        if (responseData is List) {
          return <String, dynamic>{
            'status': 'success', 
            'data': responseData
          };
        } else if (responseData is Map) {
          final Map<String, dynamic> castedResponse = Map<String, dynamic>.from(responseData);
          if (castedResponse.containsKey('data')) {
            return castedResponse;
          } else {
            return <String, dynamic>{
              'status': 'success', 
              'data': responseData
            };
          }
        } else {
          return <String, dynamic>{
            'status': 'success', 
            'data': responseData
          };
        }
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      _log('Error in getUsers: $e');
      return <String, dynamic>{
        'status': 'error', 
        'message': e.toString(), 
        'data': <dynamic>[]
      };
    }
  }
  
  static Future<Map<String, dynamic>> registerUser(Map<String, dynamic> userData) async {
    try {
      _log('Calling POST: $baseUrl/users');
      _log('Sending registration data: $userData');
      
      final response = await http.post(
        Uri.parse('$baseUrl/users'),
        headers: headers,
        body: json.encode(userData),
      ).timeout(Duration(seconds: 15));
      
      _log('Registration Response Status: ${response.statusCode}');
      _log('Registration Response Body: ${response.body}');
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        return responseData;
      } else {
        try {
          final errorData = json.decode(response.body) as Map<String, dynamic>;
          return <String, dynamic>{
            'status': 'error', 
            'message': errorData['message'] ?? 'Registration failed'
          };
        } catch (e) {
          return <String, dynamic>{
            'status': 'error', 
            'message': 'Registration failed with status: ${response.statusCode}'
          };
        }
      }
    } catch (e) {
      _log('Error in registerUser: $e');
      return <String, dynamic>{
        'status': 'error', 
        'message': 'Network error: ${e.toString()}'
      };
    }
  }
  
  static Future<Map<String, dynamic>> updateUser(int id, Map<String, dynamic> userData) async {
    try {
      _log('Calling PUT: $baseUrl/users/$id');
      
      final response = await http.put(
        Uri.parse('$baseUrl/users/$id'),
        headers: headers,
        body: json.encode(userData),
      ).timeout(Duration(seconds: 10));
      
      _log('Update User Response Status: ${response.statusCode}');
      _log('Update User Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        return responseData;
      } else {
        try {
          final errorData = json.decode(response.body) as Map<String, dynamic>;
          return <String, dynamic>{
            'status': 'error', 
            'message': errorData['message'] ?? 'Update failed'
          };
        } catch (e) {
          return <String, dynamic>{
            'status': 'error', 
            'message': 'Update failed with status: ${response.statusCode}'
          };
        }
      }
    } catch (e) {
      _log('Error in updateUser: $e');
      return <String, dynamic>{
        'status': 'error', 
        'message': 'Network error: ${e.toString()}'
      };
    }
  }
}