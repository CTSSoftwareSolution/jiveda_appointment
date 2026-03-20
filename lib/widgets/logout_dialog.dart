import 'package:flutter/material.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onYes;
  final VoidCallback onNo;

  const LogoutDialog({super.key, required this.onYes, required this.onNo});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          GestureDetector(
            onTap: onNo,
            child: Container(
              color: Colors.black.withOpacity(0.2),
              height: height,
              width: double.infinity,
            ),
          ),
          Center(
            child: Container(
              width: width * 0.8,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Do you really want to Logout ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: onNo,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: whiteColor,
                          foregroundColor: appColor,
                          side: const BorderSide(color: appColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          minimumSize: const Size(100, 36),
                        ),
                        child: const Text("No"),
                      ),
                      ElevatedButton(
                        onPressed: onYes,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColor,
                          foregroundColor: whiteColor,
                          side: const BorderSide(color: appColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          minimumSize: const Size(100, 36),
                        ),
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}