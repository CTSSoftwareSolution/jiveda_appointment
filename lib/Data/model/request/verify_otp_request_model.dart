class VerifyOtpRequestModel {
  VerifyOtpRequestModel({
    String? mobile,
    String? otp,
  }) {
    _mobile = mobile;
    _otp = otp;
  }

  VerifyOtpRequestModel.fromJson(dynamic json) {
    _mobile = json['Mobile'];
    _otp = json['otp'];
  }

  String? _mobile;
  String? _otp;

  VerifyOtpRequestModel copyWith({
    String? mobile,
    String? otp,
  }) =>
      VerifyOtpRequestModel(
        mobile: mobile ?? _mobile,
        otp: otp ?? _otp,
      );

  String? get mobile => _mobile;
  String? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Mobile'] = _mobile; 
    map['otp'] = _otp;
    return map;
  }
}