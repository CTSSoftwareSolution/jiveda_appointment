import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jiveda_appointment/Core/network/services.dart';
import 'package:jiveda_appointment/utilities/preferences.dart';

class ApiService {
  static Future<dynamic> post(dynamic body, String url) async {
    try {
      debugPrint("API url  $url");
      debugPrint("request ${jsonEncode(body.toJson())}");
      final response = await http.post(Uri.parse(url), headers: authHeader, body: jsonEncode(body.toJson()),);
      if (kDebugMode) {
        debugPrint("Alice called");
        alice.onHttpResponse(response, body: jsonEncode(body.toJson()));
      }
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint("API error  $e");
      throw Exception(e);
    }
  }

  static Future<dynamic> uploadMultipart({required String url, required String tokenID, required String patientID, required List<File> files,}) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['tokenID'] = tokenID;
      request.fields['patientID'] = patientID;
      debugPrint("TOKEN FROM PREF: ${Preferences.getTokenId()}");
      for (int i = 0; i < files.length; i++) {
        File file = files[i];

        String fileName = file.path.split('/').last;
        String extension = fileName.split('.').last;

        request.fields['files[$i].fileName'] = fileName;
        request.fields['files[$i].fileExtension'] = '.$extension';

        request.files.add(
          await http.MultipartFile.fromPath('files[$i].file', file.path,),
        );
      }
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return jsonDecode(responseData);
      } else {
        throw Exception("Upload failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("ERROR: $e");
      throw Exception(e);
    }
  }
}
