import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_alice/alice.dart';
import 'package:jiveda_appointment/utilities/preferences.dart';

const baseUrl = "https://jiveda.in/api/api";

Map<String, String> authHeader = {
  HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
};


Map<String, String> get headers => {
  ...authHeader,
  'Authorization': 'Bearer ${Preferences.getTokenId()}',
};

final navigatorKey = GlobalKey<NavigatorState>();

final alice = Alice(
  navigatorKey: navigatorKey,
  showNotification: true,
  showInspectorOnShake: true,
);

const sendOtpUrl = "$baseUrl/Account/SendOtpToMobile";
const verifyOtpUrl = "$baseUrl/Account/VerifyOtpAndRegister";
const uploadCorporatePatientDocumentUrl = "$baseUrl/Mobile/UploadCorporatePatientDocument";