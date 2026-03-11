
import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Data/repositories_impl/send_otp_repository_impl.dart';
import 'package:jiveda_appointment/Data/repositories_impl/verify_otp_repository_impl.dart';
import 'package:jiveda_appointment/Domain/usecases/send_otp_usecase.dart';
import 'package:jiveda_appointment/Domain/usecases/verify_otp_usecase.dart';
import 'package:jiveda_appointment/Presentation/providers/otp_timer_provider.dart';
import 'package:jiveda_appointment/Presentation/providers/send_otp_provider.dart';
import 'package:jiveda_appointment/Presentation/providers/splash_screen_provider.dart';
import 'package:jiveda_appointment/Presentation/providers/verify_otp_provider.dart';

import 'package:provider/provider.dart';

import '../../main.dart';




class MultipleProvider extends StatelessWidget {

  const MultipleProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
        ChangeNotifierProvider(create: (_) => SendOtpProvider(sendOtpUseCase: SendOtpUseCase(sendOtpRepository: SendOtpRepositoryImpl()))),
        ChangeNotifierProvider(create: (_) => VerifyOtpProvider(verifyOtpUseCase: VerifyOtpUseCase(verifyOtpRepository: VerifyOtpRepositoryImpl()))),
        ChangeNotifierProvider(create: (_) => OtpTimerProvider()),  
      ],
      child: const MyApp(),
    );
  }
}
