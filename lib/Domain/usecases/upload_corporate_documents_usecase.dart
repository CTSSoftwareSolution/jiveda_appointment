import 'package:jiveda_appointment/Data/model/request/upload_corporate_patient_document_request.dart';
import 'package:jiveda_appointment/Domain/repositories/upload_corporate_document_repository.dart';

class UploadDocumentsUseCase {
  final DocumentRepository repository;

  UploadDocumentsUseCase(this.repository);

  Future<dynamic> call(CorporateDocumentUploadRequestModel request) {
    return repository.uploadDocuments(request);
  }
}