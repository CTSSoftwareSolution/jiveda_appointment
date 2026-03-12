import 'dart:io';

const baseUrl = "https://jiveda.in/api/api";
String? _authToken;

Map<String, String> authHeader = {
  HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
};

void setToken(String token) {
_authToken = token;
}

Map<String, String> get headers => {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${_authToken ?? ''}',
};

const sendOtpUrl = "$baseUrl/Account/SendOtpToMobile";
const verifyOtpUrl = "$baseUrl/Account/VerifyOtpAndRegister";