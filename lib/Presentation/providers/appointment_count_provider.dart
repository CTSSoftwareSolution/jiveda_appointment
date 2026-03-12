import 'package:flutter/widgets.dart';
import 'package:jiveda_appointment/models/appointment_count_res_model.dart';

import '../../api_service.dart';

class AppointmentCountProvider extends ChangeNotifier{
  List<CountDataModel> _count = [];
  bool _isLoading = false;


  bool get isLoading => _isLoading;
  List<CountDataModel> get count => _count;

  int getCount(int statusId){
    return count.firstWhere((e) =>
    e.statusID == statusId).totalCount?.toInt() ?? 0;
  }

  Future<void> fetchCounts() async {
    _isLoading = true;
    notifyListeners();
    _count = await ApiService.fetchCounts();
    _isLoading = false;
    notifyListeners();
  }

}