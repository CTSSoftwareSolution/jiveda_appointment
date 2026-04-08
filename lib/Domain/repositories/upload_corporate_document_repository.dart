import 'package:jiveda_appointment/Data/model/request/upload_corporate_patient_document_request.dart';

abstract class DocumentRepository {
  Future<dynamic> uploadDocuments(CorporateDocumentUploadRequestModel request);
}