import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/providers/document_provider.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../utilities/color_data.dart';




Widget buildProgressHeader(BuildContext context) {
  final docProvider = context.watch<DocumentProvider>();
  return Container(
    color: whiteColor,
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: docProvider.steps[docProvider.currentStep].title,fontSize: 18,fontWeight: FontWeight.w800,textColor: blackColor,),
            CustomText(text: '${((docProvider.currentStep + 1) / docProvider.steps.length * 100).round()}%',fontSize: 14,fontWeight: FontWeight.w700,textColor: primaryColor,),
          ],
        ),
        const SizedBox(height: 4),
        CustomText(text: docProvider.steps[docProvider.currentStep].subtitle, textColor: textSecondaryColor,fontSize: 13,),
        const SizedBox(height: 12),
        AnimatedBuilder(
          animation: docProvider.progressAnim,
          builder: (context, _) => ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: docProvider.progressAnim.value,
              backgroundColor: borderColor,
              valueColor: AlwaysStoppedAnimation(docProvider.steps[docProvider.currentStep].color),
              minHeight: 6,
            ),
          ),
        ),
      ],
    ),
  );
}