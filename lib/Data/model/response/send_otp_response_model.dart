import '../../../Domain/entities/send_otp_entity.dart';

class SendOtpResponseModel extends SendOtpEntity {
  SendOtpResponseModel({
    int? success,
    String? message,
  }) {
    _success = success;
    _message = message;
  }

  SendOtpResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
  }

  int? _success;
  String? _message;

  SendOtpResponseModel copyWith({
    int? success,
    String? message,
  }) =>
      SendOtpResponseModel(
        success: success ?? _success,
        message: message ?? _message,
      );

  @override
  int? get success => _success;

  @override
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }
}