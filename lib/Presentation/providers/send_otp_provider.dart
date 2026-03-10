import 'package:flutter/cupertino.dart';

class SendOtpProvider extends ChangeNotifier{
  bool isButtonEnabled = false;
  void updateButtonState(String mobileNumber) {
    isButtonEnabled = mobileNumber.length == 10;
    notifyListeners();
  }
}