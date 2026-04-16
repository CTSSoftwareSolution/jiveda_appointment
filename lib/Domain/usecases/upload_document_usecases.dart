import 'package:jiveda_appointment/Data/model/request/upload_document_request_model.dart';
import 'package:jiveda_appointment/Domain/entities/upload_document_entity.dart';
import 'package:jiveda_appointment/Domain/repositories/upload_document_repository.dart';

class UploadDocumentUseCases {
  UploadDocumentRepository uploadDocumentRepository;
  UploadDocumentUseCases({required this.uploadDocumentRepository});
  Future<UploadDocumentEntity> execute(UploadDocumentRequestModel requestModel){
    return uploadDocumentRepository.uploadDocumentApi(requestModel);
  }
}