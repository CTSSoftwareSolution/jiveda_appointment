import 'package:extensions_pro/extensions_pro.dart';
import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/providers/bottom_navigation_provider.dart';
import 'package:jiveda_appointment/Presentation/providers/send_otp_provider.dart';
import 'package:jiveda_appointment/Presentation/screens/bottom_navigation/bottom_navigation_screen.dart';
import 'package:jiveda_appointment/utilities/preferences.dart';
import 'package:jiveda_appointment/widgets/custom_loader.dart';
import 'package:provider/provider.dart';
import '../../Data/model/request/verify_otp_request_model.dart';
import '../../Domain/entities/verify_otp_entity.dart';
import '../../Domain/usecases/verify_otp_usecase.dart';

class VerifyOtpProvider extends ChangeNotifier {
  final VerifyOtpUseCase verifyOtpUseCase;

  VerifyOtpProvider({required this.verifyOtpUseCase});

  bool isLoading = false;
  VerifyOtpEntity? verifyOtpEntity;

  final List<TextEditingController> otpControllers = List.generate(6,(_) => TextEditingController());
  
  String otp = "";

  Future<VerifyOtpEntity?> verifyOtpApi(BuildContext context) async {
    try {
      isLoading = true;
      CustomLoader.showLoader("Verifying OTP...");
      notifyListeners();

      final sendOtpProvider = Provider.of<SendOtpProvider>(context, listen: false);
      final requestModel = VerifyOtpRequestModel(mobile: sendOtpProvider.mobileController.text, otp: otp);
      final response = await verifyOtpUseCase.execute(requestModel);

      verifyOtpEntity = response;

      if (response.success != 1) {
        CustomLoader.errorMessage(response.message ?? "Invalid OTP");
      }

      return response;
    } catch (e) {
      debugPrint("verify otp error: $e");
      CustomLoader.errorMessage("Something went wrong");
      return null;
    } finally {
      isLoading = false;
      CustomLoader.closeLoader();
      FocusManager.instance.primaryFocus?.unfocus();
      notifyListeners();
    }
  }

  void verifyOtp(BuildContext context) {
    verifyOtpApi(context).then((value) async {
      final bottomNavProvider = Provider.of<BottomNavigationProvider>(context, listen: false);
      if (!context.mounted) return;
      if (value != null) {
        if (value.success == 1) {
          final user = value.data;
          await Preferences.setPreferences();
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
          otp = "";
          bottomNavProvider.updateIndex(0);
          context.push(BottomNavigationPage());

        } else {
          CustomLoader.errorMessage(
              value.message ?? "Invalid OTP");
        }
      }
    });
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
