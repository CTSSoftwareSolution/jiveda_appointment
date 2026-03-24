import 'dart:async';
import 'package:extensions_pro/extensions_pro.dart';
import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/providers/bottom_navigation_provider.dart';
import 'package:jiveda_appointment/Presentation/screens/bottom_navigation/bottom_navigation_screen.dart';
import 'package:jiveda_appointment/utilities/preferences.dart';
import 'package:provider/provider.dart';
import '../screens/login/login_screen.dart';



class SplashScreenProvider extends ChangeNotifier{

  void startTimer(BuildContext context) {
    Timer(const Duration(seconds: 2), () async {

      await Preferences.setPreferences();
      String? userId = Preferences.getUserId();

      if (!context.mounted) return;
      if (userId == null || userId.isEmpty) {
        context.pushReplacement(const LoginScreen());
      } else {
        context.read<BottomNavigationProvider>().updateIndex(0);
        context.pushReplacement(const BottomNavigationPage());
      }
    });
  }
}