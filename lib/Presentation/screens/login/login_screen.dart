import 'package:extensions_pro/extensions_pro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
  TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    final Color scaffoldBgColor = Theme.of(context).scaffoldBackgroundColor;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.height,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close, size: 24),
                          ),
                        ),
                        17.height,
                        const CustomText(
                          text: "Log in or sign up to Jiveda Appointment",
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                        10.height,
                        const CustomText(
                          text: "We will send you one time OTP on\nthis mobile number",
                          fontSize: 14,
                          textColor: blackColor,
                        ),
                        30.height,
                        SizedBox(
                          width: double.infinity,
                          child: CustomTextField(
                            controller: mobileController,
                            hint: "0000000000",
                            readOnly: false,
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.none,
                            fillColor: scaffoldBgColor,
                            inputFormatters: InputFormatters.mobileNumber,
                            validator: (value) =>
                                Validators.mobileValidation(value!, context),
                            hintStyle: const TextStyle(
                              color: textHintColor,
                              fontSize: 14,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            onChanged: (value) {
                              context.read<SendOtpProvider>().updateButtonState(value);
                            },
                          ),
                        ),
                        35.height,
                         Consumer<SendOtpProvider>(
                          builder: (context, provider, child) {
                            return CustomButton(
                              height: 50,
                              width: double.infinity,
                              buttonText: "SEND OTP",
                              onPress: provider.isButtonEnabled
                                  ? () {
                                      if (formKey.currentState!.validate()) {
                                        context.push(OtpVerificationScreen(mobileNumber: mobileController.text,));
                                      }
                                    }
                                  : () {},
                              backgroundColor: provider.isButtonEnabled
                                  ? buttonBgColor
                                  : greyColor,
                              foregroundColor: whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            );
                          },
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
                    style: const TextStyle(fontSize: 12, color: textHintColor),
                    children: [
                      const TextSpan(text: "By continuing, you agree to our\n"),
                      TextSpan(
                        text: "Terms & Conditions",
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: textHintColor,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      const TextSpan(text: " & "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: textHintColor,
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
