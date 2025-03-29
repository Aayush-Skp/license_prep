import 'dart:async';

import 'package:flutter/material.dart';
import 'package:license_entrance/app/data_provider.dart';
import 'package:license_entrance/common/shared_pref/shared_pref.dart';
import 'package:license_entrance/common/widgets/global_snackbar.dart';

class HomeScreenProvider extends ChangeNotifier {
  final DataProvider dataProvider;
  HomeScreenProvider(this.dataProvider);
  late Timer _timer;
  int _remainingSeconds = 30;
  bool _isTimerRunning = false;
  Function? _onTimerComplete;
  final Map<int, String?> selectedAnswers = {};
  bool isSubmitted = false;

  int get remainingSeconds => _remainingSeconds;
  bool get isTimerRunning => _isTimerRunning;

  void startTimer({Function? onTimerComplete}) {
    if (_isTimerRunning) {
      _timer.cancel();
    }
    _remainingSeconds = 30;
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
    _remainingSeconds = 30;
    _isTimerRunning = false;
    notifyListeners();
  }

  String getFormattedTime() {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void updateSelectedAnswer(int index, String? answer) {
    selectedAnswers[index] = answer;
    notifyListeners();
  }

  void resetState() {
    isSubmitted = false;
    selectedAnswers.clear();
    notifyListeners();
  }

  Future<void> submit({
    bool isSkillable = false,
    Function? onScrollToTop,
  }) async {
    if (selectedAnswers.length != dataProvider.responseModel?.data.length &&
        !isSkillable) {
      GlobalSnackbar.show(
        "Please attempt all questions first",
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );
      return;
    }
    if (dataProvider.isOffline) {
      resetTimer();
      return;
    }
    pauseTimer();
    isSubmitted = true;
    notifyListeners();
    if (onScrollToTop != null) {
      onScrollToTop();
    }

    int correctAnswers = 0;
    int totalQuestions = dataProvider.responseModel?.data.length ?? 0;

    for (int i = 0; i < totalQuestions; i++) {
      final question = dataProvider.responseModel?.data[i];
      if (question != null && selectedAnswers[i] == question.correctAnswer) {
        correctAnswers++;
      }
    }

    GlobalSnackbar.showCustomDialog(
      title: 'Results',
      content:
          'You got $correctAnswers out of $totalQuestions questions correct!\n'
          'Skipped questions: ${(10 - selectedAnswers.length).toString()}\n'
          'Score: ${(correctAnswers / totalQuestions * 100).toStringAsFixed(2)}%',
    );

    Map<String, dynamic> result = {
      'timestamp': DateTime.now().toIso8601String(),
      'total_questions': totalQuestions,
      'correct_answers': correctAnswers,
      'score_percentage': (correctAnswers / totalQuestions * 100)
          .toStringAsFixed(2),
    };

    await SharedPref.setResults(result);
  }

  @override
  void dispose() {
    if (_isTimerRunning) {
      _timer.cancel();
    }
    super.dispose();
  }
}
