import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jiveda_appointment/Core/network/services.dart';

class ApiService {
  static Future<dynamic> post(dynamic body, String url) async {
    try {
      debugPrint("API url  $url");
      debugPrint("request ${jsonEncode(body.toJson())}");
      final response = await http.post(
        Uri.parse(url),
        headers: authHeader,
        body: jsonEncode(body.toJson()),
      );
      debugPrint("status code  ${response.statusCode}");
      debugPrint("response  ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint("API error  $e");
      throw Exception(e);
    }
  }
}