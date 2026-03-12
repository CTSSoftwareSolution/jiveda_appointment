import 'package:jiveda_appointment/Domain/entities/appointment_list_entity.dart';

import '../../Domain/repositories/appointment_list_repository.dart';
import '../datasource/appointment_list_datasource.dart';

class AppointmentListRepositoryImpl implements AppointmentListRepository {

  @override
  Future<AppointmentListEntity> getAppointments(String statusId) async {

    final result = await AppointmentRemoteDataSource.fetchAppointments(statusId);

    return AppointmentListEntity(
        success: 1,
        data: result,
        message: "Success",
      );

  }
}