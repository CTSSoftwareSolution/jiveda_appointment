import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../utilities/color_data.dart';
import '../../providers/document_provider.dart';

Widget docPreviewRow(String label, File? file, int docType, BuildContext context) {
  final docProvider = context.watch<DocumentProvider>();
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color:
        file != null ? greenColor.withValues(alpha: 0.4) : borderColor,
      ),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: file != null
              ? Image.file(
            file,
            width: 64,
            height: 48,
            fit: BoxFit.cover,
          )
              : Container(
            width: 64,
            height: 48,
            color: surfaceColor,
            child: const Icon(Icons.image_not_supported,
                color: textSecondaryColor, size: 24),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: label,fontWeight: FontWeight.w700,textColor: blackColor,),

              const SizedBox(height: 2),
              CustomText(text:  file != null ? '✓ Captured' : '✗ Not captured',fontSize: 12,textColor: file != null ? greenColor: redColor,fontWeight: FontWeight.w600,)
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            docProvider.currentStep = docType;
            docProvider.updateProgress();
          },
          child: CustomText(text: file != null ? 'Retake' : 'Capture',fontSize: 12,)

        ),
      ],
    ),
  );
}