class CorporateDocumentUploadRequestModel {
  CorporateDocumentUploadRequestModel({
    String? tokenID,
    int? patientID,
    List<Files>? files,
  }) {
    _tokenID = tokenID;
    _patientID = patientID;
    _files = files;
  }

  CorporateDocumentUploadRequestModel.fromJson(dynamic json) {
    _tokenID = json['TokenID'];
    _patientID = json['PatientID'];
    if (json['Files'] != null) {
      _files = [];
      json['Files'].forEach((v) {
        _files?.add(Files.fromJson(v));
      });
    }
  }

  String? _tokenID;
  int? _patientID;
  List<Files>? _files;

  CorporateDocumentUploadRequestModel copyWith({
    String? tokenID,
    int? patientID,
    List<Files>? files,
  }) =>
      CorporateDocumentUploadRequestModel(
        tokenID: tokenID ?? _tokenID,
        patientID: patientID ?? _patientID,
        files: files ?? _files,
      );

  String? get tokenID => _tokenID;
  int? get patientID => _patientID;
  List<Files>? get files => _files;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TokenID'] = _tokenID;
    map['PatientID'] = _patientID;
    map['Files'] = _files?.map((v) => v.toJson()).toList() ?? [];
    return map;
  }
}

class Files {
  Files({
    String? documentName,
    String? fileExtension,
    String? filePath,
  }) {
    _documentName = documentName;
    _fileExtension = fileExtension;
    _filePath = filePath;
  }

  Files.fromJson(dynamic json) {
    _documentName = json['DocumentName'];
    _fileExtension = json['FileExtension'];
  }

  String? _documentName;
  String? _fileExtension;
  String? _filePath; // local use only

  Files copyWith({
    String? documentName,
    String? fileExtension,
    String? filePath,
  }) =>
      Files(
        documentName: documentName ?? _documentName,
        fileExtension: fileExtension ?? _fileExtension,
        filePath: filePath ?? _filePath,
      );

  String? get documentName => _documentName;
  String? get fileExtension => _fileExtension;
  String? get filePath => _filePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['DocumentName'] = _documentName;
    map['FileExtension'] = _fileExtension;
    return map;
  }
}