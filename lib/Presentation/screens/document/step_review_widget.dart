import 'package:flutter/material.dart';
import 'package:jiveda_appointment/models.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../utilities/color_data.dart';
import '../../providers/document_provider.dart';
import 'doc_preview_row_widget.dart';

Widget buildReviewStep(BuildContext context) {
  final docProvider = context.watch<DocumentProvider>();
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Client info card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: primaryColor,
                child: CustomText(text: 'widget.appointment.clientName.substring(0, 1)',fontSize: 22,fontWeight: FontWeight.w700,textColor: whiteColor,)

              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomText(text: ' widget.appointment.clientName',textColor: blackColor, fontSize: 17,fontWeight: FontWeight.w700,),
                    CustomText(text: 'widget.appointment.appointmentNumber',textColor: textSecondaryColor, fontSize: 13,),
                    CustomText(text: 'widget.appointment.clientPhone',textColor: textSecondaryColor, fontSize: 12,)

                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        CustomText(text: 'Captured Documents',fontSize: 16,fontWeight: FontWeight.w700,textColor: blackColor, ),

        const SizedBox(height: 14),
        // Document previews
        docPreviewRow('Client Photo', docProvider.clientPhoto, 0,context),
        const SizedBox(height: 12),
        docPreviewRow('ID Card', docProvider.idCardPhoto, 1,context),
        const SizedBox(height: 12),
        docPreviewRow('Aadhar Card', docProvider.aadharPhoto, 2,context),
        const SizedBox(height: 24),
        if (docProvider.isSaved)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: greenColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: greenColor.withValues(alpha: 0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: greenColor),
                SizedBox(width: 10),
                CustomText(text: 'Documents saved successfully!', textColor: greenColor, fontWeight: FontWeight.w700,)

              ],
            ),
          ),
      ],
    ),
  );
}