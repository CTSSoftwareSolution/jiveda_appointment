import 'package:extensions_pro/extensions_pro.dart';
import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/providers/send_otp_provider.dart';
import 'package:jiveda_appointment/utilities/preferences.dart';
import 'package:jiveda_appointment/widgets/custom_loader.dart';
import 'package:jiveda_appointment/Presentation/screens/appointment/appointment_screen.dart';
import '../../Data/model/request/verify_otp_request_model.dart';
import '../../Domain/entities/verify_otp_entity.dart';
import '../../Domain/usecases/verify_otp_usecase.dart';

class VerifyOtpProvider extends ChangeNotifier {
  final VerifyOtpUseCase verifyOtpUseCase;

  VerifyOtpProvider({required this.verifyOtpUseCase});

  bool isLoading = false;
  VerifyOtpEntity? verifyOtpEntity;

  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
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
      VerifyOtpRequestModel requestModel = VerifyOtpRequestModel(
        mobile: mobile,
        otp: otp,
      );
      verifyOtpEntity = await verifyOtpUseCase.execute(requestModel);
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
    required VoidCallback onSuccess,
    required SendOtpProvider sendOtpProvider,
  }) async {
    final mobile = sendOtpProvider.mobileNumber;
    final otp = getOtp();

    if (otp.length < 6) {
      CustomLoader.errorMessage("Please enter valid OTP");
      return;
    }

    CustomLoader.showLoader("Verifying OTP...");

    final response = await verifyOtpApi(mobile: mobile, otp: otp);

    CustomLoader.closeLoader();

    clearOtp();
    FocusManager.instance.primaryFocus?.unfocus();

    if (response != null && response.success == 1) {
      final user = response.data;

      Preferences.setUserId(user?.userId ?? "");
      Preferences.setUserName(user?.userName ?? "");
      Preferences.setPatientId(user?.patientId ?? "");
      Preferences.setEmail(user?.email ?? "");
      Preferences.setMobile(user?.mobile ?? "");
      Preferences.setFirstName(user?.firstName ?? "");
      Preferences.setLastName(user?.lastName ?? "");
      Preferences.setPatientName(user?.userName ?? ""); 
      Preferences.setTokenId(user?.tokenId ?? "");
      Preferences.setRoleId(user?.roleId ?? "");
      Preferences.setOrgName(user?.orgName ?? "");
      Preferences.setOrgServiceProviderId(user?.orgServiceProviderId ?? "");

      debugPrint("Preferences set:");
      debugPrint("UserId: ${Preferences.getUserId()}");
      debugPrint("UserName: ${Preferences.getUserName()}");

      onSuccess();
    } else {
      CustomLoader.errorMessage(response?.message ?? "Invalid OTP");
    }
  }

  void clearOtp() {
    for (var controller in otpControllers) {
      controller.clear();
    }
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
