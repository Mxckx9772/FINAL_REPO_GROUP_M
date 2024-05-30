
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';
class HttpService {
  final String baseUrl;

  
  HttpService() : baseUrl = Config.baseUrl;
  // Function to handle login request
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  // Function to handle registration request
  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }

  // Function to get user profile
  Future<Map<String, dynamic>> getUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get coursier profile');
    }
  }

  // Function to update user profile
  Future<Map<String, dynamic>> updateUserProfile(String token, Map<String, dynamic> profileData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(profileData),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update coursier profile');
    }
  }
// for delivery routes

// we retreive a delivery
Future<Map<String, dynamic>> getAdelivery(String token, Map<String, dynamic> coursierInfo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/deleveries'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(coursierInfo),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get delivery');
    }
  }
// we accept a delivery 
Future<Map<String, dynamic>> acceptAdelivery(String token, Map<String, dynamic> deliveryInfo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/deleveries'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(deliveryInfo),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to accept delivery');
    }
  }
  // we collect a delivery from store
  Future<Map<String, dynamic>> collectAdelivery(String token, Map<String, dynamic> deliveryInfo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/deleveries'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(deliveryInfo),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to collect delivery');
    }
  }
  // we confirm the reception of delivery by the client
  Future<Map<String, dynamic>> confirmAdelivery(String token, Map<String, dynamic> deliveryInfo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/deleveries'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(deliveryInfo),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to confirm delivery');
    }
  }

}
