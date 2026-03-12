import 'dart:convert';
import 'package:http/http.dart' as http;


import 'Data/models/appointment_count_res_model.dart';
import 'Data/models/appointment_list_res_model.dart';
import 'models.dart';


class ApiService {
  // Replace with your actual API base URL
  static const String baseUrl = 'https://jiveda.in/api/api/';
  static String? _authToken;

    static void setToken(String token) {
    _authToken = token;
  }

  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_authToken ?? ''}',
      };

  /// LOGIN
  // static Future<Map<String, dynamic>> login(
  //     String email, String password) async {
  //   // For demo - remove this block and uncomment real call
  //   await Future.delayed(const Duration(seconds: 1));
  //   if (email == 'admin@company.com' && password == 'admin123') {
  //     return {
  //       'success': true,
  //       'token': 'mock_token_12345',
  //       'user': {'name': 'Admin User', 'email': email}
  //     };
  //   }
  //   return {'success': false, 'message': 'Invalid credentials'};
  //
  //   /* Real API call:
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/auth/login'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'email': email, 'password': password}),
  //     );
  //     return jsonDecode(response.body);
  //   } catch (e) {
  //     return {'success': false, 'message': e.toString()};
  //   }
  //   */
  // }

  /// FETCH APPOINTMENTS
  // static Future<List<AppointmentDataModel>> fetchAppointments() async {
  //
  //   // Real API call:
  //   try{
  //     final uri = Uri.parse('$baseUrl/Account/GetUserAppointments').replace(
  //       queryParameters: {
  //         'TokenID': 'ccc51949-9524-45b9-816a-f26900b8292e',
  //         'StartLimit': '0',
  //         'EndLimit': '10',
  //         'LikeSearch': '',
  //         'Sort': 'AppointmentDate',
  //         'SortValue': 'DESC',
  //         'StatusID': '2',
  //         'PatientID': '45775',
  //       }
  //     );
  //     final response = await http.get(uri,
  //     headers: _headers);
  //     if(response.statusCode == 200){
  //       final json = jsonDecode(response.body);
  //       final result = AppointmentListResModel.fromJson(json);
  //
  //       return result.data ?? [];
  //     }else{
  //       return [];
  //     }
  //   }catch (e){
  //     return [];
  //   }
  //
  // }


  /// FETCH COUNTS
  // static Future<List<CountDataModel>> fetchCounts() async {
  //
  //   // Real API call:
  //   try{
  //     final uri = Uri.parse('$baseUrl/Account/GetUserAppointmentscount').replace(
  //         queryParameters: {
  //           'TokenID': 'ccc51949-9524-45b9-816a-f26900b8292e',
  //           'LikeSearch': '',
  //           'PatientID': '45775',
  //         }
  //     );
  //     final response = await http.get(
  //         uri,
  //         headers: headers);
  //     if(response.statusCode == 200){
  //       final json = jsonDecode(response.body);
  //       final result = AppointmentCountResModel.fromJson(json);
  //
  //       return result.data ?? [];
  //     }else{
  //       return [];
  //     }
  //   }catch (e){
  //     return [];
  //   }
  //
  // }

  /// UPLOAD DOCUMENTS (multipart)
  static Future<bool> uploadDocuments({
    required String appointmentId,
    String? clientPhotoPath,
    String? idCardPath,
    String? aadharPath,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;

    /* Real API call:
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/appointments/$appointmentId/documents'),
      );
      request.headers.addAll(_headers);
      if (clientPhotoPath != null) {
        request.files.add(await http.MultipartFile.fromPath('client_photo', clientPhotoPath));
      }
      if (idCardPath != null) {
        request.files.add(await http.MultipartFile.fromPath('id_card', idCardPath));
      }
      if (aadharPath != null) {
        request.files.add(await http.MultipartFile.fromPath('aadhar', aadharPath));
      }
      final response = await request.send();
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
    */
  }
}
