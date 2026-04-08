class CorporateDocumentUploadRequestModel {
  CorporateDocumentUploadRequestModel({
      String? tokenID, 
      num? patientID, 
      List<Files>? files,}){
    _tokenID = tokenID;
    _patientID = patientID;
    _files = files; 
}

  CorporateDocumentUploadRequestModel.fromJson(dynamic json) {
    _tokenID = json['tokenID'];
    _patientID = json['patientID'];
    if (json['files'] != null) {
      _files = [];
      json['files'].forEach((v) {
        _files?.add(Files.fromJson(v));
      });
    }
  }

  String? _tokenID;
  num? _patientID;
  List<Files>? _files;

CorporateDocumentUploadRequestModel copyWith({  
  String? tokenID,
  num? patientID,
  List<Files>? files,
}) => CorporateDocumentUploadRequestModel(  
  tokenID: tokenID ?? _tokenID,
  patientID: patientID ?? _patientID,
  files: files ?? _files,
);

  String? get tokenID => _tokenID;
  num? get patientID => _patientID;
  List<Files>? get files => _files;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tokenID'] = _tokenID;
    map['patientID'] = _patientID;
    if (_files != null) {
      map['files'] = _files?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Files {
  Files({
      String? fileName, 
      String? fileExtension, 
      String? filePath,}){
    _fileName = fileName;
    _fileExtension = fileExtension;
    _filePath = filePath;
}

  Files.fromJson(dynamic json) {
    _fileName = json['fileName'];
    _fileExtension = json['fileExtension'];
    _filePath = json['filePath'];
  }

  String? _fileName;
  String? _fileExtension;
  String? _filePath;

Files copyWith({  
  String? fileName,
  String? fileExtension,
  String? filePath,
}) => Files(  
  fileName: fileName ?? _fileName,
  fileExtension: fileExtension ?? _fileExtension,
  filePath: filePath ?? _filePath,
);

  String? get fileName => _fileName;
  String? get fileExtension => _fileExtension;
  String? get filePath => _filePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileName'] = _fileName;
    map['fileExtension'] = _fileExtension;
    map['filePath'] = _filePath;
    return map;
  }
}