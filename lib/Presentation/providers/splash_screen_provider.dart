import 'dart:async';
import 'package:extensions_pro/extensions_pro.dart';
import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/screens/bottom_navigation/bottom_navigation_screen.dart';
import 'package:jiveda_appointment/utilities/preferences.dart';
import '../screens/login/login_screen.dart';



class SplashScreenProvider extends ChangeNotifier{

  void startTimer(BuildContext context) {
    Timer(const Duration(seconds: 2), () async {

      await Preferences.setPreferences();
      String userId = Preferences.getUserId();

      if (userId.isEmpty) {
        if (context.mounted) {
          context.push(const LoginScreen());
        }
      } else {
        if (context.mounted) {
          context.push(const BottomNavigationPage());
        }
      }
    });
  }
}