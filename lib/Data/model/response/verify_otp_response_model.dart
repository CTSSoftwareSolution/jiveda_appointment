import '../../../Domain/entities/verify_otp_entity.dart';

class VerifyOtpResponseModel extends VerifyOtpEntity {
  VerifyOtpResponseModel({
    int? success,
    String? message,
    dynamic data,
  }) {
    _success = success;
    _message = message;
    _data = data;
  }

  VerifyOtpResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'];
  }

  int? _success;
  String? _message;
  dynamic _data;

  VerifyOtpResponseModel copyWith({
    int? success,
    String? message,
    dynamic data,
  }) =>
      VerifyOtpResponseModel(
        success: success ?? _success,
        message: message ?? _message,
        data: data ?? _data,
      );

  @override
  int? get success => _success;

  @override
  String? get message => _message;

  @override
  dynamic get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }
}