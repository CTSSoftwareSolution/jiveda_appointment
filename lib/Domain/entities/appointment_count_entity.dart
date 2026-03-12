import '../../Data/models/appointment_count_res_model.dart';

class AppointmentCountEntity {
  num? success;
  List<CountDataModel>? data;
  String? message;

  AppointmentCountEntity({ this.data, this.success, this.message});
}