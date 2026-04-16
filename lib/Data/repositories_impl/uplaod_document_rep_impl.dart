import 'package:jiveda_appointment/Data/model/request/upload_document_request_model.dart';
import 'package:jiveda_appointment/Data/model/response/upload_document_res_model.dart';
import 'package:jiveda_appointment/Domain/entities/upload_document_entity.dart';
import 'package:jiveda_appointment/Domain/repositories/upload_document_repository.dart';

import '../../Core/network/api_services.dart';
import '../../Core/network/services.dart';

class UploadDocumentRepImpl implements UploadDocumentRepository {

  @override
  Future<UploadDocumentEntity> uploadDocumentApi(UploadDocumentRequestModel requestModel) async {
    try {
      final response = await ApiService.multipartUpload(
        tokenId: requestModel.tokenID ?? '',
        patientID: requestModel.patientID ?? '',
        files: requestModel.files ?? [],
        apiUrl: uploadDocumentUrl,
      );
      final model = UploadDocumentResModel.fromJson(response);
      return UploadDocumentEntity(
        success: model.success,
        message: model.message,
        data: model.data
      );
    } catch (e) {
      throw Exception(e);
    }
  }

}