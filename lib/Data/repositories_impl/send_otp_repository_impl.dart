import '../../Core/network/api_services.dart';
import '../../Core/network/services.dart';
import '../model/request/send_otp_request_model.dart';
import '../model/response/send_otp_response_model.dart';
import '../../Domain/entities/send_otp_entity.dart';
import '../../Domain/repositories/send_otp_repository.dart';

class SendOtpRepositoryImpl implements SendOtpRepository {

  @override
  Future<SendOtpEntity> sendOtpApi(SendOtpRequestModel requestModel) async {
    try {
      final response = await ApiService.post(requestModel, sendOtpUrl);
      final model = SendOtpResponseModel.fromJson(response);
      return SendOtpEntity(
        success: model.success,
        message: model.message,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}