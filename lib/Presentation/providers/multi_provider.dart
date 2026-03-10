
import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/providers/otp_timer_provider.dart';
import 'package:jiveda_appointment/Presentation/providers/send_otp_provider.dart';
import 'package:jiveda_appointment/Presentation/providers/splash_screen_provider.dart';

import 'package:provider/provider.dart';

import '../../main.dart';




class MultipleProvider extends StatelessWidget {

  const MultipleProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
        ChangeNotifierProvider(create: (_) => SendOtpProvider()),
        ChangeNotifierProvider(create: (_) => OtpTimerProvider()),  
      ],
      child: const MyApp(),
    );
  }
}
