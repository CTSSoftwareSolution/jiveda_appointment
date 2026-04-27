import 'package:jiveda_appointment/Domain/entities/upload_corporate_document_entity.dart';


class UploadCorporatePatientDocumentResponse
    extends UploadCorporatePatientDocumentEntity {

  UploadCorporatePatientDocumentResponse({
    int? success,
    dynamic data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  UploadCorporatePatientDocumentResponse.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'];
    _message = json['message'];
  }

  int? _success;
  dynamic _data;
  String? _message;

  @override
  int? get success => _success;

  @override
  dynamic get data => _data;

  @override
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['data'] = _data;
    map['message'] = _message;
    return map;
  }
}