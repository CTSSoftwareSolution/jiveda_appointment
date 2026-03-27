import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../utilities/color_data.dart';

class OtpInputField extends StatelessWidget {
  final Function(String) onChanged;

  const OtpInputField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      autofocus: true,
      onChanged: onChanged,

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