import '../../Data/model/request/verify_otp_request_model.dart';
import '../entities/verify_otp_entity.dart';
import '../repositories/verify_otp_repository.dart';

class VerifyOtpUseCase {
  VerifyOtpRepository verifyOtpRepository;
  VerifyOtpUseCase({required this.verifyOtpRepository});
  Future<VerifyOtpEntity> execute(VerifyOtpRequestModel verifyOtpRequestModel) {
    return verifyOtpRepository.verifyOtpApi(verifyOtpRequestModel);
  }
}