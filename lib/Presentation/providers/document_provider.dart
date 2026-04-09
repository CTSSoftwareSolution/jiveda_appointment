import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiveda_appointment/Data/model/request/upload_corporate_patient_document_request.dart';
import 'package:jiveda_appointment/Domain/usecases/upload_corporate_documents_usecase.dart';
import 'package:jiveda_appointment/utilities/preferences.dart';
import 'package:path/path.dart';
import '../../utilities/color_data.dart';
import '../screens/document/step_model.dart';

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

  final UploadDocumentsUseCase  uploadDocumentsUseCase;

  DocumentProvider(this.uploadDocumentsUseCase);

  final List<StepMeta> steps = [
    StepMeta(
      title: 'Client Photo',
      subtitle: 'Take or upload client\'s face photo',
      icon: Icons.person_outline,
      color: blueColor.withValues(alpha: 0.40),
    ),
    StepMeta(
      title: 'ID Card',
      subtitle: 'Capture government issued ID card',
      icon: Icons.credit_card_outlined,
      color: lightGreen,
    ),
    StepMeta(
      title: 'Aadhar Card',
      subtitle: 'Capture Aadhar card (front & back)',
      icon: Icons.badge_outlined,
      color: blueColor.withValues(alpha: 0.40),
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

Future<void> pickFile(int docType, BuildContext context) async {
  try {
    List<String> extensions = docType == 0
        ? ['jpg', 'jpeg', 'png']
        : ['pdf', 'jpg', 'jpeg', 'png'];

    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );

    if (result == null || result.files.single.path == null) return;

    final file = File(result.files.single.path!);

    if (docType == 0) clientPhoto = file;
    if (docType == 1) idCardPhoto = file;
    if (docType == 2) aadharPhoto = file;

    notifyListeners();
  } catch (e) {
    showError("File pick failed: $e", context);
  }
}

  Future<void> save(BuildContext context, String patientId) async {
    isSaving = true;
    notifyListeners();

    try {
      List<Files> fileList = [];

      if (clientPhoto != null) {
        fileList.add(_prepareFile(clientPhoto!));
      }

      if (idCardPhoto != null) {
        fileList.add(_prepareFile(idCardPhoto!));
      }

      if (aadharPhoto != null) {
        fileList.add(_prepareFile(aadharPhoto!));
      }

      final request = CorporateDocumentUploadRequestModel(
        tokenID: Preferences.getTokenId(),
        patientID: int.parse(patientId),
        files: fileList,
      );

      final response = await uploadDocumentsUseCase.call(request);

      debugPrint("UPLOAD RESPONSE: $response");

      isSaved = true;

    } catch (e) {
      showError("Upload failed: $e", context);
    }

    isSaving = false;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
  }

  Files _prepareFile(File file) {
    String fileName = basename(file.path); 
    String ext = extension(file.path);

    return Files(
      fileName: fileName,
      fileExtension: ext,
      filePath: file.path, 
    );
  }

  void showError(String msg, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg), backgroundColor: redColor));
  }
}