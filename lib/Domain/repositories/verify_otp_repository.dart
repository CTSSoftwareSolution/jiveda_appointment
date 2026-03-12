import '../../Data/model/request/verify_otp_request_model.dart';
import '../entities/verify_otp_entity.dart';

abstract class VerifyOtpRepository {
  Future<VerifyOtpEntity> verifyOtpApi(VerifyOtpRequestModel verifyOtpRequestModel);
}