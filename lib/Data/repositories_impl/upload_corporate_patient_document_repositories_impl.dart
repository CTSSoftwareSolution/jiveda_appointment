import 'package:jiveda_appointment/Core/network/api_services.dart';
import 'package:jiveda_appointment/Core/network/services.dart';
import 'package:jiveda_appointment/Data/model/request/upload_corporate_patient_document_request.dart';
import 'package:jiveda_appointment/Data/model/response/upload_corporate_patient_document_response.dart';
import 'package:jiveda_appointment/Domain/entities/upload_corporate_document_entity.dart';
import 'package:jiveda_appointment/Domain/repositories/upload_corporate_document_repository.dart';

class DocumentRepositoryImpl implements DocumentRepository {

  @override
  Future<UploadCorporatePatientDocumentEntity> uploadCorporatePatientDocument(CorporateDocumentUploadRequestModel request) async {
    try {
      final response = await ApiService.post(request, uploadCorporatePatientDocumentUrl);
      return UploadCorporatePatientDocumentResponse.fromJson(response);
    } catch (e) {
      throw Exception("Document upload failed: $e");
    }
  }
}