import 'package:jiveda_appointment/Domain/entities/verify_otp_entity.dart';

class VerifyOtpResponseModel extends VerifyOtpEntity {
  VerifyOtpResponseModel({
    int? success,
    String? message,
    VerifyData? data,
  }) {
    _success = success;
    _message = message;
    _data = data;
  }

  VerifyOtpResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? VerifyData.fromJson(json['data']) : null;
  }

  int? _success;
  String? _message;
  VerifyData? _data;

  VerifyOtpResponseModel copyWith({
    int? success,
    String? message,
    VerifyData? data,
  }) =>
      VerifyOtpResponseModel(
        success: success ?? _success,
        message: message ?? _message,
        data: data ?? _data,
      );

  @override
  int? get success => _success;

  @override
  String? get message => _message;

  @override
  VerifyData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['data'] = _data?.toJson();
    return map;
  }
}

// Inline model, LoginData style
class VerifyData {
  VerifyData({
    String? userId,
    String? userName,
    String? email,
    String? mobile,
    String? tokenId,
    String? roleId,
    String? orgServiceProviderId,
    String? orgName,
    String? firstName,
    String? lastName,
    String? patientId,
  }) {
    _userId = userId;
    _userName = userName;
    _email = email;
    _mobile = mobile;
    _tokenId = tokenId;
    _roleId = roleId;
    _orgServiceProviderId = orgServiceProviderId;
    _orgName = orgName;
    _firstName = firstName;
    _lastName = lastName;
    _patientId = patientId;
  }

  VerifyData.fromJson(dynamic json) {
    _userId = json['UserID']?.toString();
    _userName = json['UserName']?.toString();
    _email = json['Email']?.toString();
    _mobile = json['Mobile']?.toString();
    _tokenId = json['TokenID']?.toString();
    _roleId = json['RoleID']?.toString();
    _orgServiceProviderId = json['OrgServiceProviderID']?.toString();
    _orgName = json['OrgName']?.toString();
    _firstName = json['FirstName']?.toString();
    _lastName = json['LastName']?.toString();
    _patientId = json['PatientID']?.toString();
  }

  String? _userId;
  String? _userName;
  String? _email;
  String? _mobile;
  String? _tokenId;
  String? _roleId;
  String? _orgServiceProviderId;
  String? _orgName;
  String? _firstName;
  String? _lastName;
  String? _patientId;

  VerifyData copyWith({
    String? userId,
    String? userName,
    String? email,
    String? mobile,
    String? tokenId,
    String? roleId,
    String? orgServiceProviderId,
    String? orgName,
    String? firstName,
    String? lastName,
    String? patientId,
  }) =>
      VerifyData(
        userId: userId ?? _userId,
        userName: userName ?? _userName,
        email: email ?? _email,
        mobile: mobile ?? _mobile,
        tokenId: tokenId ?? _tokenId,
        roleId: roleId ?? _roleId,
        orgServiceProviderId: orgServiceProviderId ?? _orgServiceProviderId,
        orgName: orgName ?? _orgName,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        patientId: patientId ?? _patientId,
      );

  String? get userId => _userId;
  String? get userName => _userName;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get tokenId => _tokenId;
  String? get roleId => _roleId;
  String? get orgServiceProviderId => _orgServiceProviderId;
  String? get orgName => _orgName;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get patientId => _patientId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserID'] = _userId;
    map['UserName'] = _userName;
    map['Email'] = _email;
    map['Mobile'] = _mobile;
    map['TokenID'] = _tokenId;
    map['RoleID'] = _roleId;
    map['OrgServiceProviderID'] = _orgServiceProviderId;
    map['OrgName'] = _orgName;
    map['FirstName'] = _firstName;
    map['LastName'] = _lastName;
    map['PatientID'] = _patientId;
    return map;
  }
}