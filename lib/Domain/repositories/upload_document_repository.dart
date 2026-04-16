import 'package:jiveda_appointment/Data/model/request/upload_document_request_model.dart';
import 'package:jiveda_appointment/Domain/entities/upload_document_entity.dart';

abstract class UploadDocumentRepository {
  Future<UploadDocumentEntity> uploadDocumentApi(UploadDocumentRequestModel requestModel);
}