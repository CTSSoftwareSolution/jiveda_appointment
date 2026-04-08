import '../../Core/network/api_services.dart';
import '../../Core/network/services.dart';
import '../model/request/verify_otp_request_model.dart';
import '../model/response/verify_otp_response_model.dart';
import '../../Domain/entities/verify_otp_entity.dart';
import '../../Domain/repositories/verify_otp_repository.dart';

class VerifyOtpRepositoryImpl implements VerifyOtpRepository {

  @override
  Future<VerifyOtpEntity> verifyOtpApi(VerifyOtpRequestModel verifyOtpRequestModel) async {
    try {
      final response = await ApiService.post(verifyOtpRequestModel, verifyOtpUrl);

      final model = VerifyOtpResponseModel.fromJson(response);

      return VerifyOtpResponseModel(
        success: model.success,
        message: model.message,
        data: model.data,
      );

    } catch (e) {
      throw Exception(e);
    }
  }
}