import 'package:flutter/material.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../utilities/color_data.dart';
import '../../providers/document_provider.dart';

Widget buildNavigation(BuildContext context, String appointmentId) {
  final docProvider = context.watch<DocumentProvider>();
  final isLastStep = docProvider.currentStep == docProvider.steps.length - 1;
  final statusColor = docProvider.currentStep == 0
      ? blueColor.withValues(alpha: 0.40) //lightGreen
      : docProvider.currentStep == 1
      ? lightGreen //blueColor.withValues(alpha: 0.40)
      : blueColor.withValues(alpha: 0.40); //purpleColor.withValues(alpha: 0.40);

  return Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
    child: SafeArea(
      top: false,
      child: Row(
        children: [
          if (docProvider.currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: docProvider.prev,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: CustomText(text: 'Back',textColor: blackColor,)
              ),
            ),
          if (docProvider.currentStep > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: isLastStep
                  ? (docProvider.isSaving ? null : ()=> docProvider.save(context,appointmentId))
                  : (docProvider.currentStepComplete ? docProvider.next : null),
              style: ElevatedButton.styleFrom(
                backgroundColor: isLastStep ? greenColor : statusColor,
                disabledBackgroundColor: borderColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: docProvider.isSaving
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    color: whiteColor, strokeWidth: 2),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isLastStep ? Icons.save : Icons.arrow_forward,
                    size: 18,
                    color: whiteColor,
                  ),
                  const SizedBox(width: 6),
                  CustomText(text:  isLastStep ? 'Save All Documents' : 'Continue', fontWeight: FontWeight.w700,textColor: whiteColor,)

                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}



