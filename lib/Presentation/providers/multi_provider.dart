import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/providers/document_provider.dart';
import 'package:jiveda_appointment/Presentation/providers/send_otp_provider.dart';
import 'package:jiveda_appointment/Presentation/providers/splash_screen_provider.dart';
import 'package:jiveda_appointment/Presentation/providers/verify_otp_provider.dart';
import 'package:provider/provider.dart';
import '../../Data/repositories_impl/appointment_count_rep_impl.dart';
import '../../Data/repositories_impl/appointment_list_rep_impl.dart';
import '../../Data/repositories_impl/send_otp_repository_impl.dart';
import '../../Data/repositories_impl/verify_otp_repository_impl.dart';
import '../../Domain/usecases/appointment_count_usecases.dart';
import '../../Domain/usecases/appointment_list_usecases.dart';
import '../../Domain/usecases/send_otp_usecase.dart';
import '../../Domain/usecases/verify_otp_usecase.dart';
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
        ChangeNotifierProvider(create: (_) => AppointmentListProvider(appointmentListUseCases: AppointmentListUseCases(appointmentListRepository: AppointmentListRepositoryImpl()))),
        ChangeNotifierProvider(create: (_) => AppointmentCountProvider(appointmentCountUseCases: AppointmentCountUseCases(appointmentCountRepository: AppointmentCountRepImpl()))),
        ChangeNotifierProvider(create: (_) => DocumentProvider()),
        ChangeNotifierProvider(create: (_) => SendOtpProvider(sendOtpUseCase: SendOtpUseCase(sendOtpRepository: SendOtpRepositoryImpl()))),
        ChangeNotifierProvider(create: (_) => VerifyOtpProvider(verifyOtpUseCase: VerifyOtpUseCase(verifyOtpRepository: VerifyOtpRepositoryImpl()))),
        ChangeNotifierProvider(create: (_) => DocumentProvider())
      ],
      child: const MyApp(),
    );
  }
}
