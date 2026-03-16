import 'package:jiveda_appointment/Domain/entities/appointment_list_entity.dart';
import 'package:jiveda_appointment/Domain/repositories/appointment_list_repository.dart';

class AppointmentListUseCases {
  final AppointmentListRepository appointmentListRepository;

  AppointmentListUseCases({required this.appointmentListRepository});

  Future<AppointmentListEntity> call(String statusId) async {
    return await appointmentListRepository.getAppointments(statusId);
  }
}