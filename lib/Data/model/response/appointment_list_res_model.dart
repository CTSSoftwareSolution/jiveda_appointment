class AppointmentListResModel {
  AppointmentListResModel({
      num? success, 
      List<AppointmentDataModel>? data,
      String? message,}){
    _success = success;
    _data = data;
    _message = message;
}

  AppointmentListResModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AppointmentDataModel.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _success;
  List<AppointmentDataModel>? _data;
  String? _message;
AppointmentListResModel copyWith({  num? success,
  List<AppointmentDataModel>? data,
  String? message,
}) => AppointmentListResModel(  success: success ?? _success,
  data: data ?? _data,
  message: message ?? _message,
);
  num? get success => _success;
  List<AppointmentDataModel>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

class AppointmentDataModel {
  AppointmentDataModel({
      num? count, 
      String? appointmentID, 
      String? patientID, 
      String? appointmentDate, 
      String? timing, 
      String? statusID, 
      String? statusName, 
      String? patientName, 
      String? corporateID, 
      String? isUploadDoc,}){
    _count = count;
    _appointmentID = appointmentID;
    _patientID = patientID;
    _appointmentDate = appointmentDate;
    _timing = timing;
    _statusID = statusID;
    _statusName = statusName;
    _patientName = patientName;
    _corporateID = corporateID;
    _isUploadDoc = isUploadDoc;
}

  AppointmentDataModel.fromJson(dynamic json) {
    _count = json['Count'];
    _appointmentID = json['AppointmentID'];
    _patientID = json['PatientID'];
    _appointmentDate = json['AppointmentDate'];
    _timing = json['Timing'];
    _statusID = json['StatusID'];
    _statusName = json['StatusName'];
    _patientName = json['PatientName'];
    _corporateID = json['corporateID'];
    _isUploadDoc = json['IsUploadDoc'];
  }
  num? _count;
  String? _appointmentID;
  String? _patientID;
  String? _appointmentDate;
  String? _timing;
  String? _statusID;
  String? _statusName;
  String? _patientName;
  String? _corporateID;
  String? _isUploadDoc;
  AppointmentDataModel copyWith({  num? count,
  String? appointmentID,
  String? patientID,
  String? appointmentDate,
  String? timing,
  String? statusID,
  String? statusName,
  String? patientName,
  String? corporateID,
  String? isUploadDoc,
}) => AppointmentDataModel(  count: count ?? _count,
  appointmentID: appointmentID ?? _appointmentID,
  patientID: patientID ?? _patientID,
  appointmentDate: appointmentDate ?? _appointmentDate,
  timing: timing ?? _timing,
  statusID: statusID ?? _statusID,
  statusName: statusName ?? _statusName,
  patientName: patientName ?? _patientName,
  corporateID: corporateID ?? _corporateID,
  isUploadDoc: isUploadDoc ?? _isUploadDoc,
);
  num? get count => _count;
  String? get appointmentID => _appointmentID;
  String? get patientID => _patientID;
  String? get appointmentDate => _appointmentDate;
  String? get timing => _timing;
  String? get statusID => _statusID;
  String? get statusName => _statusName;
  String? get patientName => _patientName;
  String? get corporateID => _corporateID;
  String? get isUploadDoc => _isUploadDoc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Count'] = _count;
    map['AppointmentID'] = _appointmentID;
    map['PatientID'] = _patientID;
    map['AppointmentDate'] = _appointmentDate;
    map['Timing'] = _timing;
    map['StatusID'] = _statusID;
    map['StatusName'] = _statusName;
    map['PatientName'] = _patientName;
    map['corporateID'] = _corporateID;
    map['IsUploadDoc'] = _isUploadDoc;
    return map;
  }

}