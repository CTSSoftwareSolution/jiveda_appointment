import 'package:jiveda_appointment/Data/model/response/verify_otp_response_model.dart';

class VerifyOtpEntity {
  final int? success;
  final String? message;
  final VerifyData? data;

  VerifyOtpEntity({
    this.success,
    this.message,
    this.data,
  });
}