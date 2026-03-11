import '../../Data/model/request/send_otp_request_model.dart';
import '../entities/send_otp_entity.dart';
import '../repositories/send_otp_repository.dart';

class SendOtpUseCase {
  SendOtpRepository sendOtpRepository;
  SendOtpUseCase({required this.sendOtpRepository});
  Future<SendOtpEntity> execute(SendOtpRequestModel requestModel) {
    return sendOtpRepository.sendOtpApi(requestModel);
  }
}