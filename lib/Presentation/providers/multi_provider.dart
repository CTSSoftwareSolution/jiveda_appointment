import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/providers/auth_provider.dart';
import 'package:jiveda_appointment/Presentation/providers/document_provider.dart';
import 'package:jiveda_appointment/Presentation/providers/send_otp_provider.dart';
import 'package:jiveda_appointment/Presentation/providers/splash_screen_provider.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import 'appointment_count_provider.dart';
import 'appointment_list_provider.dart';




class MultipleProvider extends StatelessWidget {

  const MultipleProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
        ChangeNotifierProvider(create: (_) => SendOtpProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentListProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentCountProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DocumentProvider())
      ],
      child: const MyApp(),
    );
  }
}
