import 'package:flutter/material.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';

class OtpFieldRow extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  const OtpFieldRow({
    super.key,
    required this.controllers,
    required this.focusNodes,
  });

  Widget otpBox(BuildContext context, int index) {
    return Container(
      width: 45,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: focusNodes[index].hasFocus
              ? appColor
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) => otpBox(context, index)),
    );
  }
}