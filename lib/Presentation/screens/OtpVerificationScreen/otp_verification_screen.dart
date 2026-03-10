import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';
import 'package:jiveda_appointment/utilities/extension.dart';
import 'package:jiveda_appointment/widgets/custom_button.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpVerificationScreen({super.key, required this.mobileNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  int seconds = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          seconds--;
        });
      }
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
    timer?.cancel();
    super.dispose();
  }

  Widget otpBox(int index) {
    return Container(
      width: 45,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: focusNodes[index].hasFocus
              ? buttonBgColor
              : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
          }
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.height,
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back, size: 24),
              ),
              15.height,
              const CustomText(
                text: "OTP Verification",
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              10.height,
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, color: textHintColor, height: 1.4,),
                  children: [
                    TextSpan(
                      text: "We have sent a verification code to\n+91 - ${widget.mobileNumber}  ",
                    ),
                    const TextSpan(
                      text: "(Edit?)",
                      style: TextStyle(color: textColor),
                    ),
                  ],
                ),
              ),
              35.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) => otpBox(index)),
              ),
              20.height,
              Center(
                child: CustomText(
                  text: seconds == 0
                      ? "Resend OTP"
                      : "Resend in 00:${seconds.toString().padLeft(2, '0')}",
                  fontSize: 14,
                  textColor: textHintColor,
                ),
              ),
              40.height,
              CustomButton(
                height: 50,
                width: double.infinity,
                buttonText: "VERIFY",
                onPress: () {},
                backgroundColor: buttonBgColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
