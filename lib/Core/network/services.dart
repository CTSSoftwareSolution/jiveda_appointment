import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_alice/alice.dart';

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

final navigatorKey = GlobalKey<NavigatorState>();

final alice = Alice(
  navigatorKey: navigatorKey,
  showNotification: true,
  showInspectorOnShake: true,
);

const sendOtpUrl = "$baseUrl/Account/SendOtpToMobile";
const verifyOtpUrl = "$baseUrl/Account/VerifyOtpAndRegister";