import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jiveda_appointment/utilities/preferences.dart';
import '../../Core/network/services.dart';
import '../model/response/appointment_list_res_model.dart';

class AppointmentRemoteDataSource {


  static Future<List<AppointmentDataModel>> fetchAppointments(String statusId) async {



    try{
      final uri = Uri.parse('$baseUrl/Account/GetUserAppointments').replace(
          queryParameters: {
            'TokenID': Preferences.getTokenId(),
            'StartLimit': '0',
            'EndLimit': '10',
            'LikeSearch': '',
            'Sort': 'AppointmentDate',
            'SortValue': 'DESC',
            'StatusID': statusId,
            'PatientID': Preferences.getPatientId(),
          }
      );
      final response = await http.get(uri,
          headers: headers);

      if (kDebugMode) {
        alice.onHttpResponse(response, body: jsonEncode({
          'TokenID': Preferences.getTokenId(),
          'StartLimit': '0',
          'EndLimit': '10',
          'LikeSearch': '',
          'Sort': 'AppointmentDate',
          'SortValue': 'DESC',
          'StatusID': statusId,
          'PatientID': Preferences.getPatientId(),
        }));
      }

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        final result = AppointmentListResModel.fromJson(json);

        return result.data ?? [];
      }else{
        return [];
      }
    }catch (e){
      return [];
    }

  }
}