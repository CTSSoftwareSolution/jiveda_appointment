import 'package:jiveda_appointment/Domain/entities/appointment_count_entity.dart';
import 'package:jiveda_appointment/Domain/repositories/appointment_count_repository.dart';

class AppointmentCountUseCases {
  final AppointmentCountRepository appointmentCountRepository;

  AppointmentCountUseCases({required this.appointmentCountRepository});

  Future<AppointmentCountEntity> call()async{
    return await appointmentCountRepository.getAppointmentCount();
  }
}