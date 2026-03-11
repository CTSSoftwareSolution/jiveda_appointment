import 'package:flutter/material.dart';
import 'package:jiveda_appointment/models/appointment_list_res_model.dart';
import '../../api_service.dart';
import '../../models.dart';

class AppointmentListProvider extends ChangeNotifier {
  List<AppointmentDataModel> _appointments = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<AppointmentDataModel> get appointments => _filtered;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  List<AppointmentDataModel> get _filtered {
    if (_searchQuery.isEmpty) return _appointments;
    final q = _searchQuery.toLowerCase();
    return _appointments.where((a) {
      return a.patientName!.toLowerCase().contains(q) ||
          a.appointmentID!.toLowerCase().contains(q);
    }).toList();
  }

  void setSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> fetchAppointments() async {
    _isLoading = true;
    notifyListeners();
    _appointments = await ApiService.fetchAppointments();
    _isLoading = false;
    notifyListeners();
  }

  // void updateAppointmentDocs(String id,
  //     {String? clientPhoto, String? idCard, String? aadhar}) {
  //   final idx = _appointments.indexWhere((a) => a.appointmentID == id);
  //   if (idx != -1) {
  //     if (clientPhoto != null) _appointments[idx].clientPhotoPath = clientPhoto;
  //     if (idCard != null) _appointments[idx].idCardPhotoPath = idCard;
  //     if (aadhar != null) _appointments[idx].aadharPhotoPath = aadhar;
  //     _appointments[idx].isDocumentUploaded = true;
  //     notifyListeners();
  //   }
  // }
}