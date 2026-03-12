import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Core/network/services.dart';
import '../model/response/appointment_list_res_model.dart';

class AppointmentRemoteDataSource {


  static Future<List<AppointmentDataModel>> fetchAppointments(String statusId) async {



    try{
      final uri = Uri.parse('$baseUrl/Account/GetUserAppointments').replace(
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
          headers: headers);
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