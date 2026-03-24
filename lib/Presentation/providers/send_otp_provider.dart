import 'package:flutter/material.dart';
import 'package:jiveda_appointment/utilities/preferences.dart';
import 'package:jiveda_appointment/widgets/custom_loader.dart';
import '../../Data/model/request/send_otp_request_model.dart';
import '../../Domain/entities/send_otp_entity.dart';
import '../../Domain/usecases/send_otp_usecase.dart';
import '../../utilities/color_data.dart';

class SendOtpProvider extends ChangeNotifier {
  final SendOtpUseCase sendOtpUseCase;

  SendOtpProvider({required this.sendOtpUseCase});

  final TextEditingController mobileController = TextEditingController();

  bool isLoading = false;
  SendOtpEntity? sendOtpEntity;

  bool get isButtonEnabled => mobileController.text.length == 10;

  Color get sendButtonColor => isButtonEnabled ? appColor : buttonBgGreyColor;

  Future<bool> sendOtpApi() async {
    try {
      isLoading = true;
      CustomLoader.showLoader("Sending OTP...");
      notifyListeners();
      final mobile = mobileController.text;
      final requestModel = SendOtpRequestModel(mobile: int.parse(mobile));
      final response = await sendOtpUseCase.execute(requestModel);
      if (response.success == 1) {
        await Preferences.setMobileNumber(mobile);
        return true;
      } else {
        CustomLoader.errorMessage(response.message ?? "Failed to send OTP");
        return false;
      }
    } catch (e) {
      debugPrint("SEND OTP error $e");
      CustomLoader.errorMessage("Something went wrong");
      return false;
    } finally {
      isLoading = false;
      CustomLoader.closeLoader();
      notifyListeners();
    }
  }

  void onMobileChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }
}
