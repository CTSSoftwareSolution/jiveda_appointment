import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Data/repositories_impl/appointment_count_rep_impl.dart';
import 'package:jiveda_appointment/Data/repositories_impl/appointment_list_rep_impl.dart';
import 'package:jiveda_appointment/Domain/usecases/appointment_count_usecases.dart';
import 'package:jiveda_appointment/Domain/usecases/appointment_list_usecases.dart';
import 'package:jiveda_appointment/Presentation/providers/document_provider.dart';
import 'package:jiveda_appointment/Presentation/providers/otp_timer_provider.dart';
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
        ChangeNotifierProvider(create: (_) => AppointmentListProvider(appointmentListUseCases: AppointmentListUseCases(appointmentListRepository: AppointmentListRepositoryImpl()))),
        ChangeNotifierProvider(create: (_) => AppointmentCountProvider(appointmentCountUseCases: AppointmentCountUseCases(appointmentCountRepository: AppointmentCountRepImpl()))),
        ChangeNotifierProvider(create: (_) => DocumentProvider()),
        ChangeNotifierProvider(create: (_) => OtpTimerProvider())
      ],
      child: const MyApp(),
    );
  }
}
