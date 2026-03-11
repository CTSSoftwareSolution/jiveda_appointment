import 'dart:io';

const baseUrl = "https://jiveda.in/api/api";

Map<String, String> authHeader = {
  HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
};

const sendOtpUrl = "$baseUrl/Account/SendOtpToMobile";
const verifyOtpUrl = "$baseUrl/Account/VerifyOtpAndRegister";