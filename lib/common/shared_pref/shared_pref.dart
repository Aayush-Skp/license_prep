import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const _quizResult = 'quiz_results';
  static const _currentPageNumber = "current_page";
  static const _myTime = 'my_time';

  static Future<List<dynamic>> getResults() async {
    final instance = await SharedPreferences.getInstance();
    List<dynamic> quizResults = instance.getStringList(_quizResult) ?? [];
    return quizResults.map((result) => json.decode(result)).toList();
  }

  static Future<void> setResults(dynamic result) async {
    final instance = await SharedPreferences.getInstance();
    List<String> quizResults = instance.getStringList(_quizResult) ?? [];
    quizResults.add(json.encode(result));
    await instance.setStringList(_quizResult, quizResults);
  }

  static Future<int> getPageNumber() async {
    final instance = await SharedPreferences.getInstance();
    final res = instance.getInt(_currentPageNumber);
    return res ?? 1;
  }

  static Future setPageNumber(value) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setInt(_currentPageNumber, value);
  }

  static Future<int> getTime() async {
    final instance = await SharedPreferences.getInstance();
    final res = instance.getInt(_myTime);
    return res ?? 30;
  }

  static Future setTime(value) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setInt(_myTime, value);
  }
}
