import 'package:extensions_pro/extensions_pro.dart';
import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/screens/OtpVerificationScreen/otp_verification_screen.dart';
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

 Future<SendOtpEntity?> sendOtpApi() async {
  try {
    isLoading = true;
    CustomLoader.showLoader("Sending OTP...");
    notifyListeners();
    final mobile = mobileController.text;
    final requestModel = SendOtpRequestModel(mobile: int.parse(mobile));
    final response = await sendOtpUseCase.execute(requestModel);
    sendOtpEntity = response;
    if (response.success != 1) {
      CustomLoader.errorMessage(response.message ?? "Failed to send OTP");
    }
    return response;
  } catch (e) {
    debugPrint("SEND OTP error $e");
    CustomLoader.errorMessage("Something went wrong");
    return null;
  } finally {
    isLoading = false;
    CustomLoader.closeLoader();
    notifyListeners();
  }
}

void sendOtp(BuildContext context) {
  sendOtpApi().then((value) {
    if (!context.mounted) return;

    if (value != null && value.success == 1) {
      context.push(const OtpVerificationScreen());
    } else {
      CustomLoader.errorMessage(value?.message ?? "Failed to send OTP");
    }
  });
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
