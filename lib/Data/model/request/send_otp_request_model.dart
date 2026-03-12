class SendOtpRequestModel {
  SendOtpRequestModel({
    int? mobile,
  }) {
    _mobile = mobile;
  }

  SendOtpRequestModel.fromJson(dynamic json) {
    _mobile = json['mobile'];
  }

  int? _mobile;

  SendOtpRequestModel copyWith({int? mobile,}) => SendOtpRequestModel( mobile: mobile ?? _mobile,);

  int? get mobile => _mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile'] = _mobile;
    return map;
  }
}