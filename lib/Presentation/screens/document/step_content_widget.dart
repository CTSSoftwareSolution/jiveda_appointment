import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiveda_appointment/Presentation/screens/document/step_review_widget.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart'; 

import '../../../utilities/color_data.dart';
import '../../providers/document_provider.dart';
import 'image_picker_widget.dart';

Widget buildStepContent(BuildContext context) {
  final docProvider = context.watch<DocumentProvider>();
  if (docProvider.currentStep == 3) return buildReviewStep(context);

  final docType = docProvider.currentStep;
  final file =
      docType == 0 ? docProvider.clientPhoto : docType == 1 ? docProvider.idCardPhoto : docProvider.aadharPhoto;

  bool isPdf = file != null && extension(file.path).toLowerCase() == '.pdf'; 

  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        // Photo area
        GestureDetector(
          onTap: () => showImagePicker(docType,context),
          child: Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: file != null
                    ? docProvider.steps[docProvider.currentStep].color
                    : borderColor,
                width: file != null ? 2 : 1,
                style: file != null
                    ? BorderStyle.solid
                    : BorderStyle.solid,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: file != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(19),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        isPdf
                            ? Container(
                                color: Colors.white,
                                child: const Center(
                                  child: Icon(Icons.picture_as_pdf,
                                      size: 60, color: Colors.red),
                                ),
                              )
                            : Image.file(file, fit: BoxFit.cover),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit, color: Colors.white, size: 16),
                                SizedBox(width: 6),
                                CustomText(text: 'Tap to retake',textColor: whiteColor,fontSize: 13,fontWeight: FontWeight.w600,)
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: greenColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check,
                                color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: docProvider.steps[docProvider.currentStep].color.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          docProvider.steps[docProvider.currentStep].icon,
                          size: 40,
                          color: docProvider.steps[docProvider.currentStep].color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomText(text: 'No photo yet',fontSize: 18,fontWeight: FontWeight.w700,textColor: blackColor,),
                      const SizedBox(height: 6),
                      CustomText(text: 'Tap to capture or upload',textColor: textSecondaryColor,fontSize: 14,)
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 20),
        // Action buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => docProvider.pickImage(ImageSource.camera, docType,context),
                icon: const Icon(Icons.camera_alt),
                label: CustomText(text: 'Camera'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: docProvider.steps[docProvider.currentStep].color,
                  side: BorderSide(color: docProvider.steps[docProvider.currentStep].color),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => docProvider.pickFile(docType,context),
                icon: const Icon(Icons.upload_file),
                label: CustomText(text: docType == 0 ? 'Photo Gallery' : 'PDF / Gallery',),
                style: OutlinedButton.styleFrom(
                  foregroundColor: docProvider.steps[docProvider.currentStep].color,
                  side: BorderSide(color: docProvider.steps[docProvider.currentStep].color),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: docProvider.steps[docProvider.currentStep].color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: docProvider.steps[docProvider.currentStep].color.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb_outline,
                      color: docProvider.steps[docProvider.currentStep].color, size: 18),
                  const SizedBox(width: 8),
                  CustomText(text: 'Guidelines', fontSize: 14,fontWeight: FontWeight.w700,textColor: docProvider.steps[docProvider.currentStep].color,)
                ],
              ),
              const SizedBox(height: 8),
              ..._getGuidelinesFor(docProvider.currentStep).map((tip) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.circle,
                            size: 6,
                            color: docProvider.steps[docProvider.currentStep].color),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomText(text: tip,textColor: docProvider.steps[docProvider.currentStep].color.withValues(alpha: 0.8),fontSize: 12,)
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}

List<String> _getGuidelinesFor(int step) {
  if (step == 0) {
    return [
      'Ensure face is clearly visible and well-lit',
      'Remove sunglasses or hats',
      'Look directly at the camera',
      'White or plain background preferred',
    ];
  } else if (step == 1) {
    return [
      'Capture all four corners of the ID',
      'Ensure text is clearly readable',
      'Avoid glare and shadows',
      'Accepted: Passport, Driving License, Voter ID',
    ];
  } else {
    return [
      'Capture both front and back of Aadhar card',
      'All 12 digits must be clearly visible',
      'Ensure the QR code is visible',
      'Photo and name should be clear',
    ];
  }
}