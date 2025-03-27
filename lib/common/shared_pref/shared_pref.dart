import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const _quizResult = 'quiz_results';
  static const _currentPageNumber = "current_page";

  static Future getResults() async {
    final instance = await SharedPreferences.getInstance();
    List<dynamic> quizResults = instance.getStringList(_quizResult) ?? [];
    return quizResults;
  }

  static Future setResults(result) async {
    final instance = await SharedPref.getResults();
    List<dynamic> quizResults = instance.getStringList(_quizResult) ?? [];
    quizResults.add(result);
    await instance.setStringList(
      _quizResult,
      quizResults.map((result) => json.encode(result)).toList(),
    );
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
}
