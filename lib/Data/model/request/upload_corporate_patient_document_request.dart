class CorporateDocumentUploadRequestModel {
  final String tokenID;
  final int patientID;
  final List<Files> files;

  CorporateDocumentUploadRequestModel({
    required this.tokenID,
    required this.patientID,
    required this.files,
  });
}

class Files {
  final String fileName;
  final String fileExtension;
  final String filePath;

  Files({
    required this.fileName,
    required this.fileExtension,
    required this.filePath,
  });
}