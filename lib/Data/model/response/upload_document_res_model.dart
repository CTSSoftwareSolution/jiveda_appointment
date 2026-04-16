class UploadDocumentResModel {
  UploadDocumentResModel({
      num? success, 
      List<dynamic>? data, 
      String? message,}){
    _success = success;
    _data = data;
    _message = message;
}

  UploadDocumentResModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      // json['data'].forEach((v) {
      //   _data?.add(Dynamic.fromJson(v));
      // });
    }
    _message = json['message'];
  }
  num? _success;
  List<dynamic>? _data;
  String? _message;
UploadDocumentResModel copyWith({  num? success,
  List<dynamic>? data,
  String? message,
}) => UploadDocumentResModel(  success: success ?? _success,
  data: data ?? _data,
  message: message ?? _message,
);
  num? get success => _success;
  List<dynamic>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}