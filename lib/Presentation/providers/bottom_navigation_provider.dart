import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/screens/appointment/appointment_screen.dart';
import 'package:jiveda_appointment/Presentation/screens/dashboard/home_screen.dart';
import 'package:jiveda_appointment/Presentation/screens/profile/profile_screen.dart';

class BottomNavigationProvider extends ChangeNotifier {

  int currentIndex = 0;

  List<Widget> currentScreen = [
    const HomeScreen(),
    const AppointmentScreen(),
    const ProfileScreen(),
  ];

  void updateIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }

}