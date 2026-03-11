import 'package:flutter/cupertino.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';

class SendOtpProvider extends ChangeNotifier{
  String mobileNumber = "";
  bool isButtonEnabled = false;
  void updateButtonState(String value) {
    mobileNumber = value;
    isButtonEnabled = mobileNumber.length == 10;
    notifyListeners();
  }

  Color get sendButtonColor => isButtonEnabled ? appColor : buttonBgGreyColor;

  void onSendOtp(VoidCallback pushOtpScreen) {
    if (isButtonEnabled) {
      pushOtpScreen();
    }
  }
}