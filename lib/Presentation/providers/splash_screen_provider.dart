import 'dart:async';
import 'package:extensions_pro/extensions_pro.dart';
import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/screens/bottom_navigation/bottom_navigation_screen.dart';
import '../screens/login/login_screen.dart';



class SplashScreenProvider extends ChangeNotifier{

  void startTimer(BuildContext context){
    Timer(Duration(seconds: 2),
            (){ context.push(BottomNavigationPage()); });
  }
}