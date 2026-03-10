import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/screens/appointment/appointment_screen.dart';

import 'Presentation/providers/multi_provider.dart';




void main() {
  runApp(MultipleProvider());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AppointmentScreen()
    );
  }
}

