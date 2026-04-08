import 'package:jiveda_appointment/Core/network/api_services.dart';
import 'package:jiveda_appointment/Data/model/request/upload_corporate_patient_document_request.dart';
import 'package:jiveda_appointment/Domain/repositories/upload_corporate_document_repository.dart';
import '../../Core/network/services.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  @override
  Future<dynamic> uploadDocuments(
    CorporateDocumentUploadRequestModel request,
  ) async {
    return await ApiService.post(request, uploadCorporatePatientDocumentUrl);
  }
}
