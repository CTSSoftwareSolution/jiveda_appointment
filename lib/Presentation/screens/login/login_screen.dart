import 'package:extensions_pro/extensions_pro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiveda_appointment/Presentation/screens/OtpVerificationScreen/otp_verification_screen.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';
import 'package:jiveda_appointment/utilities/extension.dart';
import 'package:jiveda_appointment/utilities/input_formatters.dart';
import 'package:jiveda_appointment/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../../utilities/validators.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../providers/send_otp_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
void initState() {
  super.initState();
  final provider = context.read<SendOtpProvider>();
  provider.mobileController.addListener(() {
    provider.notifyListeners();
  });
}

  @override
  Widget build(BuildContext context) {
    final Color scaffoldBgColor = Theme.of(context).scaffoldBackgroundColor;
    final screenWidth = MediaQuery.of(context).size.width;
    final provider = context.watch<SendOtpProvider>();
    final sendOtpProvider = provider;
    final buttonColor = provider.sendButtonColor;
    final isEnabled = provider.isButtonEnabled;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              10.height,
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.04),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      SystemNavigator.pop();
                    },
                    child: const Icon(Icons.close, size: 24, color: greyColor),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        17.height,
                        const CustomText(
                          text: "Log in or sign up to Jiveda Appointment",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        10.height,
                        const CustomText(
                          text:
                              "We will send you one time OTP on\nthis mobile number",
                          fontSize: 15,
                          textColor: blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                        30.height,
                        SizedBox(
                          width: double.infinity,
                          child: CustomTextField(
                            controller: sendOtpProvider.mobileController,
                            hint: "0000000000",
                            readOnly: false,
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.none,
                            fillColor: scaffoldBgColor,
                            inputFormatters: InputFormatters.mobileNumber,
                            validator: null,
                            hintStyle: const TextStyle(
                              color: textHintColor,
                              fontSize: 14,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                          ),
                        ),
                        35.height,
                        CustomButton(
                          buttonText: "SEND OTP",
                          onPress: () async{
                            if (!isEnabled || sendOtpProvider.isLoading) return;
                               final response = await sendOtpProvider.sendOtpApi();
                                if (response?.success == 1) {
                                    context.push(const OtpVerificationScreen());
                                  }
                               },
                          backgroundColor: buttonColor,
                          foregroundColor: whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          width: double.infinity,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 13,
                      color: blackColor,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                    children: [
                      const TextSpan(text: "By continuing, you agree to our\n"),
                      TextSpan(
                        text: "Terms & Conditions",
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      const TextSpan(text: " & "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
