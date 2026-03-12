import 'package:extensions_pro/extensions_pro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/providers/send_otp_provider.dart';
import 'package:jiveda_appointment/Presentation/screens/appointment/appointment_screen.dart';
import 'package:jiveda_appointment/utilities/otp_fields.dart';
import 'package:provider/provider.dart';
import 'package:jiveda_appointment/Presentation/providers/otp_timer_provider.dart';
import 'package:jiveda_appointment/widgets/custom_button.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';
import 'package:jiveda_appointment/utilities/extension.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OtpTimerProvider>().startTimer();
    });
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final mobileNumber = context.watch<SendOtpProvider>().mobileNumber;
    final otpSeconds = context.watch<OtpTimerProvider>().seconds;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.height,
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.04),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, size: 24, color: greyColor),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    15.height,
                    const CustomText(
                      text: "OTP Verification",
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    10.height,
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 15,
                          color: blackColor,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: "We have sent a verification code to\n+91 - $mobileNumber  ",
                          ),
                          TextSpan(
                            text: "(Edit?)",
                            style: const TextStyle(color: greenColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              },
                          ),
                        ],
                      ),
                    ),
                    35.height,
                    OtpFieldRow(
                      controllers: controllers,
                      focusNodes: focusNodes,
                    ),
                    20.height,
                    Center(
                      child: CustomText(
                        text: otpSeconds == 0
                            ? "Resend OTP"
                            : "Resend in 00:${otpSeconds.toString().padLeft(2, '0')}",
                        fontSize: 14,
                        textColor: blackColor,
                      ),
                    ),
                    40.height,
                    CustomButton(
                      height: 50,
                      width: double.infinity,
                      buttonText: "VERIFY",
                      onPress: () {
                        context.push(AppointmentScreen());
                      },
                      backgroundColor: appColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
