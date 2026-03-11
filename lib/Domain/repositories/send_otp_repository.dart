import '../../Data/model/request/send_otp_request_model.dart';
import '../entities/send_otp_entity.dart';

abstract class SendOtpRepository {
  Future<SendOtpEntity> sendOtpApi(SendOtpRequestModel requestModel);
}