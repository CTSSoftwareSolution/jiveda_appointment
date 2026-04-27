import 'package:jiveda_appointment/Data/model/request/upload_corporate_patient_document_request.dart';
import 'package:jiveda_appointment/Domain/entities/upload_corporate_document_entity.dart';

abstract class DocumentRepository {
  Future<UploadCorporatePatientDocumentEntity> uploadCorporatePatientDocument(CorporateDocumentUploadRequestModel request);
}