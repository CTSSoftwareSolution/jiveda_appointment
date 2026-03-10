import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../api_service.dart';
import '../../utilities/color_data.dart';
import '../screens/document/step_model.dart';
import 'appointment_provider.dart';

class DocumentProvider extends ChangeNotifier {

  late Animation<double> progressAnim;
  int currentStep = 0;
  final picker = ImagePicker();
  late AnimationController animCtrl;
  File? clientPhoto;
  File? idCardPhoto;
  File? aadharPhoto;
  bool isSaving = false;
  bool isSaved = false;

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


  Future<void> save(BuildContext context, String appointmentId) async {
    final docProvider = Provider.of<DocumentProvider>(context,listen: false);
     docProvider.isSaving = true;
    await ApiService.uploadDocuments(
      appointmentId: appointmentId,
      clientPhotoPath: docProvider.clientPhoto?.path,
      idCardPath: docProvider.idCardPhoto?.path,
      aadharPath: docProvider.aadharPhoto?.path,
    );
    // context.read<AppointmentProvider>().updateAppointmentDocs(
    //   appointmentId,
    //   clientPhoto: docProvider.clientPhoto?.path,
    //   idCard: docProvider.idCardPhoto?.path,
    //   aadhar: docProvider.aadharPhoto?.path,
    // );

      docProvider.isSaving = false;
      docProvider.isSaved = true;
      notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
  }

  void showError(String msg, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg), backgroundColor: redColor));
  }
}