

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiveda_appointment/Presentation/providers/document_provider.dart';
import 'package:jiveda_appointment/Presentation/screens/document/source_button_widget.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../utilities/color_data.dart';

void showImagePicker(int docType, BuildContext context) {
  final docProvider = Provider.of<DocumentProvider>(context,listen: false);
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            CustomText(text: 'Choose Source',fontSize: 18,fontWeight: FontWeight.w700,textColor: blackColor, ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: sourceButton(
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    color: primaryColor,
                    onTap: () {
                      Navigator.pop(context);
                      docProvider.pickImage(ImageSource.camera, docType, context);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: sourceButton(
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    color: blueColor,
                    onTap: () {
                      Navigator.pop(context);
                      docProvider.pickImage(ImageSource.gallery, docType, context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    ),
  );
}


