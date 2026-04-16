import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jiveda_appointment/Core/network/services.dart';

import '../../Data/model/request/upload_document_request_model.dart';
import '../../utilities/preferences.dart';

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

  static Future<Map<String, dynamic>?> multipartUpload({
    required String tokenId,
    required String patientID,
    required List<Files> files,
    required String apiUrl,
  }) async {
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer ${Preferences.getTokenId()}',
    };
    final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers.addAll(headers);
    request.fields['tokenID'] = tokenId;
    request.fields['patientID'] = patientID;

    for (final file in files) {
      if (file.filePath == null || file.filePath!.isEmpty) continue;

      final fileObj = File(file.filePath!);

      if (await fileObj.exists()) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'files',
            file.filePath!,
            filename: file.fileName,
          ),
        );

        request.fields['fileExtension'] = file.fileExtension ?? '';
      }
    }


    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (kDebugMode) {
      alice.onHttpResponse(response, body: request.fields);
    }

    final responseBody = await compute(_decodeResponse, response.bodyBytes);
    return responseBody;
  }


  static Map<String, dynamic> _decodeResponse(Uint8List bodyBytes) {
    return jsonDecode(utf8.decode(bodyBytes));
  }
}