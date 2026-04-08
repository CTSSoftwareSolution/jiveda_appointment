import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../utilities/color_data.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;

  const OtpInputField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      length: 6,
      autofocus: true,
      autofillHints: const [],

      defaultPinTheme: PinTheme(
        width: 50,
        height: 48,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: blackColor,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
      ),

      focusedPinTheme: PinTheme(
        width: 50,
        height: 48,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: blackColor,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: appColor, width: 1.5),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}