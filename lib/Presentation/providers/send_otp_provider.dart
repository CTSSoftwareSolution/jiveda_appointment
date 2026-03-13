import 'package:flutter/material.dart';
import 'package:jiveda_appointment/utilities/preferences.dart';
import '../../Data/model/request/send_otp_request_model.dart';
import '../../Domain/entities/send_otp_entity.dart';
import '../../Domain/usecases/send_otp_usecase.dart';
import '../../utilities/color_data.dart';

class SendOtpProvider extends ChangeNotifier {

  final SendOtpUseCase sendOtpUseCase;

  SendOtpProvider({required this.sendOtpUseCase});

  final TextEditingController mobileController = TextEditingController();

  String mobileNumber = "";
  bool isButtonEnabled = false;
  bool isLoading = false;

  SendOtpEntity? sendOtpEntity;

  void updateButtonState(String value) {
    mobileNumber = value;
    isButtonEnabled = mobileNumber.length == 10;
    notifyListeners();
  }

  Color get sendButtonColor => isButtonEnabled ? appColor : buttonBgGreyColor;

   Future<SendOtpEntity?> sendOtpApi() async {
    try {
      isLoading = true;
      notifyListeners();
      SendOtpRequestModel requestModel = SendOtpRequestModel(mobile: int.parse(mobileNumber));
      sendOtpEntity = await sendOtpUseCase.execute(requestModel);
      debugPrint("OTP response success ${sendOtpEntity?.success}");
      debugPrint("OTP response message ${sendOtpEntity?.message}");
      return sendOtpEntity;
    } catch (e) {
      debugPrint("SEND OTP error $e");
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void onSendOtp(VoidCallback pushOtpScreen) async {
    if (!isButtonEnabled) return;
    final response = await sendOtpApi();
    if (response != null && response.success == 1) {
      await Preferences.setMobileNumber(mobileNumber);
      debugPrint("OTP sent successfully");
      pushOtpScreen();
    } else {
      debugPrint("OTP failed");
    }
  }
}