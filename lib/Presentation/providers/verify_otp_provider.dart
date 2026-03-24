import 'package:flutter/material.dart';
import 'package:jiveda_appointment/utilities/preferences.dart';
import 'package:jiveda_appointment/widgets/custom_loader.dart';
import '../../Data/model/request/verify_otp_request_model.dart';
import '../../Domain/entities/verify_otp_entity.dart';
import '../../Domain/usecases/verify_otp_usecase.dart';

class VerifyOtpProvider extends ChangeNotifier {
  final VerifyOtpUseCase verifyOtpUseCase;

  VerifyOtpProvider({required this.verifyOtpUseCase});

  bool isLoading = false;
  VerifyOtpEntity? verifyOtpEntity;

  final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());

  String getOtp() {
    return otpControllers.map((e) => e.text).join();
  }

  Future<VerifyOtpEntity?> verifyOtpApi() async {
    try {
      isLoading = true;
      notifyListeners();

      final mobile = Preferences.getMobileNumber();
      final otp = getOtp();

      final requestModel = VerifyOtpRequestModel(
        mobile: mobile ?? "",
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

  Future<bool> onVerifyOtp() async {
    final otp = getOtp();

    if (otp.length < 6) {
      CustomLoader.errorMessage("Please enter valid OTP");
      return false;
    }
    CustomLoader.showLoader("Verifying OTP...");

    try {
      final response = await verifyOtpApi();

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

        return true;
      } else {
        CustomLoader.errorMessage(response?.message ?? "Invalid OTP");
        return false;
      }
    } catch (e) {
      CustomLoader.errorMessage("Something went wrong");
      return false;
    } finally {
      CustomLoader.closeLoader();
      clearOtp();
      FocusManager.instance.primaryFocus?.unfocus();
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
