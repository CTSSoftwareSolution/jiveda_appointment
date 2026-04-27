import 'package:jiveda_appointment/Domain/entities/upload_corporate_document_entity.dart';
import '../../Data/model/request/upload_corporate_patient_document_request.dart';
import '../repositories/upload_corporate_document_repository.dart';

class UploadCorporateDocumentUseCase {
  DocumentRepository repository;

  UploadCorporateDocumentUseCase({required this.repository});

  Future<UploadCorporatePatientDocumentEntity> execute(
      CorporateDocumentUploadRequestModel requestModel) {
    return repository.uploadCorporatePatientDocument(requestModel);
  }
}