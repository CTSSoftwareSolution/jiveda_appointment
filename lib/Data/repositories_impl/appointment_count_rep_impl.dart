import 'package:jiveda_appointment/Data/datasource/appointment_count_datasource.dart';
import 'package:jiveda_appointment/Domain/entities/appointment_count_entity.dart';
import 'package:jiveda_appointment/Domain/repositories/appointment_count_repository.dart';

class AppointmentCountRepImpl implements AppointmentCountRepository {

  @override
  Future<AppointmentCountEntity> getAppointmentCount() async{

    final result = await AppointmentCountDatasource.fetchCounts();

    return AppointmentCountEntity(success: 1,data: result,message: "Success");
  }


}