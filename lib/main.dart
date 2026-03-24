import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jiveda_appointment/Presentation/screens/appointment/appointment_screen.dart';
import 'package:jiveda_appointment/Presentation/screens/login/login_screen.dart';
import 'package:jiveda_appointment/Presentation/screens/splash/splash_screen.dart';
import 'package:jiveda_appointment/utilities/preferences.dart';

import 'Presentation/providers/multi_provider.dart';




void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(const MultipleProvider());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: AppointmentScreen()
      home: SplashScreen()
    );
  }
}
