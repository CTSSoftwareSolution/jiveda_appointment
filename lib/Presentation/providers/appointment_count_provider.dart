import 'package:flutter/widgets.dart';
import 'package:jiveda_appointment/Domain/entities/appointment_count_entity.dart';
import 'package:jiveda_appointment/Domain/usecases/appointment_count_usecases.dart';


import '../../Data/models/appointment_count_res_model.dart';
import '../../api_service.dart';

class AppointmentCountProvider extends ChangeNotifier{

  AppointmentCountUseCases? appointmentCountUseCases;

  AppointmentCountProvider({required this.appointmentCountUseCases});

 // List<CountDataModel> _count = [];
  bool _isLoading = false;

  AppointmentCountEntity? appointmentCountEntity;

  bool get isLoading => _isLoading;
  List<CountDataModel> get count => appointmentCountEntity?.data ?? [];



  int getCount(int statusId){
    return count.firstWhere((e) =>
    e.statusID == statusId).totalCount?.toInt() ?? 0;
  }

  Future<void> fetchCounts() async {
    _isLoading = true;
    notifyListeners();
    appointmentCountEntity = await appointmentCountUseCases!.call();
    _isLoading = false;
    notifyListeners();
  }

}