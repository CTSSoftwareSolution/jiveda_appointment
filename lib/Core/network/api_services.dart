import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jiveda_appointment/Core/network/services.dart';
import 'package:jiveda_appointment/utilities/preferences.dart';
import 'package:http_parser/http_parser.dart';

class ApiService {
  static Future<dynamic> post(dynamic body, String url) async {
    try {
      debugPrint("API url  $url");
      debugPrint("request ${jsonEncode(body.toJson())}");
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body.toJson()),
      );
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

  static Future<dynamic> uploadMultipart({
    required String url,
    required String tokenID,
    required String patientID,
    required List<File> files,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers['Authorization'] = 'Bearer ${Preferences.getTokenId()}';

      request.fields['tokenID'] = tokenID;
      request.fields['patientID'] = patientID;

      for (int i = 0; i < files.length; i++) {
        final file = files[i];
        final fileName = file.path.split('/').last;
        final extension = fileName.split('.').last;

        request.fields['files[$i].fileName'] = fileName;
        request.fields['files[$i].fileExtension'] = '.$extension';

        final type = extension.toLowerCase() == 'pdf'
            ? MediaType('application', 'pdf')
            : MediaType('image', 'jpeg');

        request.files.add(
          await http.MultipartFile.fromPath(
            'files[$i].file',
            file.path,
            contentType: type,
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint("STATUS CODE: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      if (kDebugMode) {
        alice.onHttpResponse(
          response,
          body: {
            "fields": request.fields,
            "files": files.map((e) => e.path).toList(),
          },
        );
      }

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Upload failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("ERROR: $e");
      throw Exception(e);
    }
  }
}
