import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Domain/entities/appointment_list_entity.dart';
import 'package:provider/provider.dart';

import '../../Data/model/response/appointment_list_res_model.dart';
import '../../Domain/usecases/appointment_list_usecases.dart';
import '../../api_service.dart';
import '../../models.dart';
import 'appointment_count_provider.dart';

class AppointmentListProvider extends ChangeNotifier {

  AppointmentListUseCases? appointmentListUseCases;

  AppointmentListProvider({required this.appointmentListUseCases});

 //  List<AppointmentDataModel> _appointments = [];
  bool _isLoading = false;
  String _searchQuery = '';
  late TabController tabController;
  final searchCtrl = TextEditingController();

  String statusId = "";
  void setStatusId(String id) {
    statusId = id;
  }


  AppointmentListEntity? appointmentListEntity;

  AppointmentDataModel? _selectedAppointment;

  AppointmentDataModel? get selectedAppointment => _selectedAppointment;

  void setSelectedAppointment(AppointmentDataModel appointment) {
    _selectedAppointment = appointment;
    notifyListeners();
  }

  List<AppointmentDataModel> get appointments =>
      appointmentListEntity?.data ?? [];

 // List<AppointmentDataModel> get appointments => _filtered;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  List<AppointmentDataModel> get filteredAppointments {
    final list = appointments;
    if (_searchQuery.isEmpty) return list;

    final q = _searchQuery.toLowerCase();
    return list.where((a) {
      return a.patientName!.toLowerCase().contains(q) ||
          a.appointmentID!.toLowerCase().contains(q);
    }).toList();
  }

  void setSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void listenTabChanges(BuildContext context) {
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        switch (tabController.index) {
          case 0: // All
            statusId = "";
            break;
          case 1: // Scheduled
            statusId = "2";
            break;
          case 2: // Completed
            statusId = "1";
            break;
          case 3: // Cancelled
            statusId = "4";
            break;
        }

        fetchAppointments();
      }
    });
  }


  Future<void> fetchAppointments() async {
    _isLoading = true;
    notifyListeners();

    appointmentListEntity = await appointmentListUseCases!.call(statusId);

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