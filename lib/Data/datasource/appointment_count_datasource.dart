import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jiveda_appointment/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:jiveda_appointment/utilities/preferences.dart';
import '../../Core/network/services.dart';
import '../model/response/appointment_count_res_model.dart';

class AppointmentCountDatasource {

  static Future<List<CountDataModel>> fetchCounts() async {

    // Real API call:
    try{
      final uri = Uri.parse('$baseUrl/Account/GetUserAppointmentscount').replace(
          queryParameters: {
            'TokenID': Preferences.getTokenId(),
            'LikeSearch': '',
            'PatientID': Preferences.getPatientId(),
          }
      );
      final response = await http.get(
          uri,
          headers: headers);
      if (kDebugMode) {
        alice.onHttpResponse(response, body: jsonEncode({
          'TokenID': Preferences.getTokenId(),
          'LikeSearch': '',
          'PatientID': Preferences.getPatientId(),
        }));
      }
      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        final result = AppointmentCountResModel.fromJson(json);

        return result.data ?? [];
      }else{
        return [];
      }
    }catch (e){
      return [];
    }

  }
}