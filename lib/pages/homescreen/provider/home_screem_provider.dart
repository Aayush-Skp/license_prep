import 'dart:async';

import 'package:flutter/material.dart';
import 'package:license_entrance/app/data_provider.dart';

class HomeScreenProvider extends ChangeNotifier {
  final DataProvider dataProvider;
  HomeScreenProvider(this.dataProvider);
  late Timer _timer;
  int _remainingSeconds = 10;
  bool _isTimerRunning = false;
  Function? _onTimerComplete;

  int get remainingSeconds => _remainingSeconds;
  bool get isTimerRunning => _isTimerRunning;

  void startTimer({Function? onTimerComplete}) {
    if (_isTimerRunning) {
      _timer.cancel();
    }
    _remainingSeconds = 10;
    _isTimerRunning = true;
    _onTimerComplete = onTimerComplete;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        _timer.cancel();
        _isTimerRunning = false;
        if (_onTimerComplete != null) {
          _onTimerComplete!();
        }
      }
    });
    notifyListeners();
  }

  void pauseTimer() {
    if (_isTimerRunning) {
      _timer.cancel();
      _isTimerRunning = false;
      notifyListeners();
    }
  }

  void resumeTimer() {
    if (!_isTimerRunning && _remainingSeconds > 0) {
      startTimer(onTimerComplete: _onTimerComplete);
    }
  }

  void resetTimer() {
    if (_isTimerRunning) {
      _timer.cancel();
    }
    _remainingSeconds = 10;
    _isTimerRunning = false;
    notifyListeners();
  }

  String getFormattedTime() {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    if (_isTimerRunning) {
      _timer.cancel();
    }
    super.dispose();
  }
}
