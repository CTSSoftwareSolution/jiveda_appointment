import 'package:jiveda_appointment/Data/model/response/user_model.dart';

class VerifyOtpEntity {
  final int? success;
  final String? message;
  final UserModel? data;

  VerifyOtpEntity({
    this.success,
    this.message,
    this.data,
  });
}