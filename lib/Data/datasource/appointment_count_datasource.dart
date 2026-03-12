import 'dart:convert';

import 'package:jiveda_appointment/api_service.dart';
import 'package:http/http.dart' as http;
import '../../Core/network/services.dart';
import '../model/response/appointment_count_res_model.dart';

class AppointmentCountDatasource {

  static Future<List<CountDataModel>> fetchCounts() async {

    // Real API call:
    try{
      final uri = Uri.parse('$baseUrl/Account/GetUserAppointmentscount').replace(
          queryParameters: {
            'TokenID': 'ccc51949-9524-45b9-816a-f26900b8292e',
            'LikeSearch': '',
            'PatientID': '45775',
          }
      );
      final response = await http.get(
          uri,
          headers: headers);
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