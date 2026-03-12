import 'package:jiveda_appointment/Domain/entities/appointment_count_entity.dart';

abstract class AppointmentCountRepository {
  Future<AppointmentCountEntity> getAppointmentCount();
}