import 'package:flutter/material.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';

import 'custom_text.dart';
import 'custom_button.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onYes;
  final VoidCallback onNo;

  const LogoutDialog({
    super.key,
    required this.onYes,
    required this.onNo,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          GestureDetector(
            onTap: onNo,
            child: Container(
              color: Colors.black.withOpacity(0.3),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Center(
            child: Container(
              width: width * 0.82,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 36,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomText(
                    text: "Do you really want to Logout ?",
                    textAlign: TextAlign.center,
                    textColor: blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          buttonText: "No",
                          onPress: onNo,
                          backgroundColor: whiteColor,
                          foregroundColor: appColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: const BorderSide(color: appColor),
                          height: 42,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: CustomButton(
                          buttonText: "Yes",
                          onPress: onYes,
                          backgroundColor: appColor,
                          foregroundColor: whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: const BorderSide(color: appColor),
                          height: 42,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}