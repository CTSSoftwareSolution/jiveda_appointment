import 'dart:async';
import 'package:flutter/material.dart';

class OtpTimerProvider extends ChangeNotifier {
  int seconds = 30;
  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    seconds = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        _timer?.cancel();
      } else {
        seconds--;
        notifyListeners();
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}