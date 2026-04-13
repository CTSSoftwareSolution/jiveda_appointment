import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:jiveda_appointment/Core/network/api_services.dart';
import 'package:jiveda_appointment/Data/model/request/upload_corporate_patient_document_request.dart';
import 'package:jiveda_appointment/Domain/repositories/upload_corporate_document_repository.dart';
import '../../Core/network/services.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  @override
  Future<dynamic> uploadDocuments(
    CorporateDocumentUploadRequestModel request,
  ) async {
    debugPrint("TOKEN: ${request.tokenID}");
    debugPrint("PATIENT ID: ${request.patientID}");
    debugPrint("FILES COUNT: ${request.files.length}");
    for (var f in request.files) {
      debugPrint("FILE PATH: ${f.filePath}");
    }
    final fileList = request.files.map((e) {
      final file = File(e.filePath);
      debugPrint("EXISTS: ${file.existsSync()} PATH: ${file.path}");
      return file;
    }).toList();

    return await ApiService.uploadMultipart(
      url: uploadCorporatePatientDocumentUrl,
      tokenID: request.tokenID, 
      patientID: request.patientID.toString(),
      files: fileList,
    );
  }
}