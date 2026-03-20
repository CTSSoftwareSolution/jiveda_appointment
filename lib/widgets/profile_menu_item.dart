import 'package:flutter/material.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';

import 'custom_text.dart';
import 'custom_image.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String imagePath;

  const MenuItem({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: appColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: CustomImage(
              image: imagePath,
              height: 20,
              width: 20,
              color: whiteColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomText(
              text: title,
              fontSize: 16,
              textColor: blackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: textHintColor),
        ],
      ),
    );
  }
}