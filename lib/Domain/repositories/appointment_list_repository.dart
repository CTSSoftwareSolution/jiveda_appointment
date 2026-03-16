import 'package:jiveda_appointment/Domain/entities/appointment_list_entity.dart';

abstract class AppointmentListRepository {
  Future<AppointmentListEntity> getAppointments(String statusId);
}