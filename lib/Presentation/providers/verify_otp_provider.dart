import 'package:extensions_pro/extensions_pro.dart';
import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/screens/appointment/appointment_screen.dart';
import '../../Data/model/request/verify_otp_request_model.dart';
import '../../Domain/entities/verify_otp_entity.dart';
import '../../Domain/usecases/verify_otp_usecase.dart';

class VerifyOtpProvider extends ChangeNotifier {

  final VerifyOtpUseCase verifyOtpUseCase;

  VerifyOtpProvider({required this.verifyOtpUseCase});

  bool isLoading = false;
  VerifyOtpEntity? verifyOtpEntity;

  final List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());

  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  String getOtp() {
    return otpControllers.map((e) => e.text).join();
  }

  Future<VerifyOtpEntity?> verifyOtpApi({
    required String mobile,
    required String otp,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      VerifyOtpRequestModel requestModel = VerifyOtpRequestModel(mobile: mobile, otp: otp);
      verifyOtpEntity = await verifyOtpUseCase.execute(requestModel);
      debugPrint("verify otp success ${verifyOtpEntity?.success}");
      debugPrint("verify otp message ${verifyOtpEntity?.message}");
      debugPrint("verify otp data ${verifyOtpEntity?.data}");
      return verifyOtpEntity;
    } catch (e) {
      debugPrint("verify otp error: $e");
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  void onVerifyOtp({
    required String mobile, required BuildContext context
  }) async {

    final otp = getOtp();
    final response = await verifyOtpApi(mobile: mobile, otp: otp);

    if (response != null) {
      debugPrint("verify response success ${response.success}");
      debugPrint("verify response message ${response.message}");
      context.push(AppointmentScreen());
    }
  }
  
  void clearOtp() {
    for (var controller in otpControllers) {
      controller.clear();
    }
  }
}