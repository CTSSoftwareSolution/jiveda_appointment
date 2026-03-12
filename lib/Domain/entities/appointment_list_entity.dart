
import '../../Data/model/response/appointment_list_res_model.dart';


class AppointmentListEntity {
  num? success;
  List<AppointmentDataModel>? data;
  String? message;

  AppointmentListEntity({this.data, this.message, this.success});

}