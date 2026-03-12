import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jiveda_appointment/api_service.dart';
import 'package:provider/provider.dart';
import '../../Presentation/providers/appointment_count_provider.dart';
import '../models/appointment_list_res_model.dart';

class AppointmentRemoteDataSource {


  static Future<List<AppointmentDataModel>> fetchAppointments(String statusId) async {



    try{
      final uri = Uri.parse('${ApiService.baseUrl}/Account/GetUserAppointments').replace(
          queryParameters: {
            'TokenID': 'ccc51949-9524-45b9-816a-f26900b8292e',
            'StartLimit': '0',
            'EndLimit': '10',
            'LikeSearch': '',
            'Sort': 'AppointmentDate',
            'SortValue': 'DESC',
            'StatusID': statusId,
            'PatientID': '45775',
          }
      );
      final response = await http.get(uri,
          headers: ApiService.headers);
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