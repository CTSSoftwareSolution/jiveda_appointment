import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiveda_appointment/Core/network/api_services.dart';
import 'package:jiveda_appointment/Domain/usecases/upload_document_usecases.dart';
import 'package:jiveda_appointment/utilities/preferences.dart';
import 'package:provider/provider.dart';
import '../../Data/model/request/upload_document_request_model.dart';
import '../../api_service.dart';
import '../../utilities/color_data.dart';
import '../screens/document/step_model.dart';
import 'appointment_list_provider.dart';
import 'package:path/path.dart' as path;

class DocumentProvider extends ChangeNotifier {

  final UploadDocumentUseCases uploadDocumentUseCases;

  DocumentProvider({required this.uploadDocumentUseCases});

  late Animation<double> progressAnim;
  int currentStep = 0;
  final picker = ImagePicker();
  late AnimationController animCtrl;
  File? clientPhoto;
  File? idCardPhoto;
  File? aadharPhoto;
  bool isSaving = false;
  bool isSaved = false;
  List<Files> uploadFiles = [];

  final List<StepMeta> steps = [
    StepMeta(
      title: 'Client Photo',
      subtitle: 'Take or upload client\'s face photo',
      icon: Icons.person_outline,
      color: blueColor.withValues(alpha: 0.40), //lightGreen,
    ),
    StepMeta(
      title: 'ID Card',
      subtitle: 'Capture government issued ID card',
      icon: Icons.credit_card_outlined,
      color: lightGreen//blueColor.withValues(alpha: 0.40),
    ),
    StepMeta(
      title: 'Aadhar Card',
      subtitle: 'Capture Aadhar card (front & back)',
      icon: Icons.badge_outlined,
      color: blueColor.withValues(alpha: 0.40), //purpleColor.withValues(alpha: 0.40),
    ),
    StepMeta(
      title: 'Review & Save',
      subtitle: 'Verify documents and save',
      icon: Icons.check_circle_outline,
      color:greenColor,
    ),
  ];

  bool get currentStepComplete {
    if (currentStep == 0) return clientPhoto != null;
    if (currentStep == 1) return idCardPhoto != null;
    if (currentStep == 2) return aadharPhoto != null;
    return true;
  }

  void next() {
    if (currentStep < steps.length - 1) {
       currentStep++;
      updateProgress();
      notifyListeners();
    }
  }

  void prev() {
    if (currentStep > 0) {
      currentStep--;
      updateProgress();
      notifyListeners();
    }
  }

  void updateProgress() {
    animCtrl.animateTo((currentStep + 1) / steps.length);
    notifyListeners();
  }

  Future<void> pickImage(ImageSource source, int docType, BuildContext context) async {
    try {
      final picked = await picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
      );
      if (picked == null) return;

        if (docType == 0) clientPhoto = File(picked.path);
        if (docType == 1) idCardPhoto = File(picked.path);
        if (docType == 2) aadharPhoto = File(picked.path);
        notifyListeners();

    } catch (e) {
      showError('Failed to pick image: $e',context);
    }
  }


  Future<void> save(BuildContext context) async {

     isSaving = true;

     if (clientPhoto != null) {
       uploadFiles.add(
         Files(
           fileName: path.basename(clientPhoto!.path),
           fileExtension: path.extension(clientPhoto!.path).replaceFirst('.', ''),
           filePath: clientPhoto!.path,
         ),
       );
     }

     if (idCardPhoto != null) {
       uploadFiles.add(
         Files(
           fileName: path.basename(idCardPhoto!.path),
           fileExtension: path.extension(idCardPhoto!.path).replaceFirst('.', ''),
           filePath: idCardPhoto!.path,
         ),
       );
     }

     if (aadharPhoto != null) {
       uploadFiles.add(
         Files(
           fileName: path.basename(aadharPhoto!.path),
           fileExtension: path.extension(aadharPhoto!.path).replaceFirst('.', ''),
           filePath: aadharPhoto!.path,
         ),
       );
     }

    try{
      UploadDocumentRequestModel request = UploadDocumentRequestModel(
        tokenID: Preferences.getTokenId(),
        patientID: Preferences.getPatientId(),
        files: uploadFiles
      );

      final response = await uploadDocumentUseCases.execute(request);

      if (response.success == 1) {
        isSaved = true;
        Navigator.pop(context);
      } else {
        showError(response.message ?? "Upload failed", context);
      }

    } catch (e){
      showError("Something went wrong: $e", context);
    }


     isSaving = false;
      isSaved = true;
      notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
  }

  void showError(String msg, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg), backgroundColor: redColor));
  }
}