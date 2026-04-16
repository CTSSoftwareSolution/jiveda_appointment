import '../../../Domain/entities/appointment_count_entity.dart';

class AppointmentCountResModel extends AppointmentCountEntity {
  AppointmentCountResModel({
      num? success, 
      List<CountDataModel>? data,
      String? message,}){
    _success = success;
    _data = data;
    _message = message;
}

  AppointmentCountResModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CountDataModel.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _success;
  List<CountDataModel>? _data;
  String? _message;
AppointmentCountResModel copyWith({  num? success,
  List<CountDataModel>? data,
  String? message,
}) => AppointmentCountResModel(  success: success ?? _success,
  data: data ?? _data,
  message: message ?? _message,
);
  num? get success => _success;
  List<CountDataModel>? get data => _data;
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

class CountDataModel {
  CountDataModel({
      num? statusID, 
      String? statusName, 
      num? totalCount,}){
    _statusID = statusID;
    _statusName = statusName;
    _totalCount = totalCount;
}

  CountDataModel.fromJson(dynamic json) {
    _statusID = json['StatusID'];
    _statusName = json['StatusName'];
    _totalCount = json['TotalCount'];
  }
  num? _statusID;
  String? _statusName;
  num? _totalCount;
  CountDataModel copyWith({  num? statusID,
  String? statusName,
  num? totalCount,
}) => CountDataModel(  statusID: statusID ?? _statusID,
  statusName: statusName ?? _statusName,
  totalCount: totalCount ?? _totalCount,
);
  num? get statusID => _statusID;
  String? get statusName => _statusName;
  num? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusID'] = _statusID;
    map['StatusName'] = _statusName;
    map['TotalCount'] = _totalCount;
    return map;
  }

}