import 'package:flutter/material.dart';
import 'package:license_entrance/app/data_provider.dart';
import 'package:license_entrance/common/shared_pref/shared_pref.dart';
import 'package:license_entrance/common/widgets/app_buttons.dart';
import 'package:license_entrance/common/widgets/common_loading_widget.dart';
import 'package:license_entrance/common/widgets/common_pages/offline_page.dart';
import 'package:license_entrance/common/widgets/global_snackbar.dart';
import 'package:license_entrance/pages/homescreen/components/questions_block_widget.dart';
import 'package:license_entrance/pages/homescreen/provider/home_screem_provider.dart';
import 'package:license_entrance/utility/extension.dart';
import 'package:provider/provider.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final timerProvider = context.homeScreenProvider;
      if (timerProvider.remainingSeconds == 10 &&
          !timerProvider.isTimerRunning) {
        timerProvider.startTimer(
          onTimerComplete: () {
            _submit(isSkillable: true);
          },
        );
      }
    });
  }

  void _updateSelectedAnswer(int index, String? answer) {
    setState(() {
      context.dataProvider.selectedAnswers[index] = answer;
    });
  }

  void _resetState() {
    setState(() {
      context.dataProvider.isSubmitted = false;
      context.dataProvider.selectedAnswers.clear();
    });
  }

  void _submit({bool isSkillable = false}) async {
    if (context.dataProvider.selectedAnswers.length !=
            context.dataProvider.responseModel?.data.length &&
        !isSkillable) {
      GlobalSnackbar.show(
        "Please attempt all questions first",
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );
      return;
    }
    setState(() {
      context.dataProvider.isSubmitted = true;
    });
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 1200),
      curve: Curves.easeInOut,
    );

    int correctAnswers = 0;
    int totalQuestions = context.dataProvider.responseModel?.data.length ?? 0;

    for (int i = 0; i < totalQuestions; i++) {
      final question = context.dataProvider.responseModel?.data[i];
      if (question != null &&
          context.dataProvider.selectedAnswers[i] == question.correctAnswer) {
        correctAnswers++;
      }
    }
    GlobalSnackbar.showCustomDialog(
      title: 'Results',
      content:
          'You got $correctAnswers out of $totalQuestions questions correct!\n'
          'Skipped questions: ${(10 - context.dataProvider.selectedAnswers.length).toString()}\n'
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer2<DataProvider, HomeScreenProvider>(
        builder: (context, provider, timerProvider, child) {
          List<Widget> questionWidgets = [];
          if (provider.responseModel?.data != null) {
            questionWidgets =
                provider.responseModel!.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  final datum = entry.value;
                  RegExp regExp = RegExp(r'Q\d+:\s*(.*)');
                  Match? match = regExp.firstMatch(datum.question);
                  final question = match?.group(1) ?? '';
                  return QuestionBlockWidget(
                    options: datum.options,
                    question: question,
                    correctAnswer: datum.correctAnswer,
                    isSubmitted: provider.isSubmitted,
                    selectedAnswer: context.dataProvider.selectedAnswers[index],
                    onAnswerSelected:
                        (value) => _updateSelectedAnswer(index, value),
                  );
                }).toList();
          }
          return provider.isLoading
              ? CommonLoadingWidget()
              : provider.isOffline
              ? OfflinePage(
                onRefresh: () async {
                  final currentContext = context;
                  if (currentContext.mounted) {
                    provider.fetchData();
                  }
                },
              )
              : Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        ...questionWidgets,
                        SizedBox(height: 5),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 5),
                            Expanded(
                              child: AppButtons(
                                onClicked: () {
                                  GlobalSnackbar.show(
                                    "You are currently on page no: ${provider.currentPageNo}",
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                  );
                                },
                                title: provider.currentPageNo.toString(),
                              ),
                            ),
                            SizedBox(width: 7),
                            Expanded(
                              flex: 4,
                              child: AppButtons(
                                title:
                                    provider.isSubmitted
                                        ? "Next Page"
                                        : 'Submit',
                                onClicked: () async {
                                  if (provider.isSubmitted) {
                                    final currentContext = context;
                                    await SharedPref.setPageNumber(
                                      provider.currentPageNo + 1,
                                    );
                                    _resetState();
                                    timerProvider.resetTimer();
                                    timerProvider.startTimer(
                                      onTimerComplete: () {
                                        _submit(isSkillable: true);
                                      },
                                    );
                                    if (currentContext.mounted) {
                                      provider.fetchData();
                                    }
                                  } else {
                                    timerProvider.pauseTimer();
                                    _submit();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: SafeArea(
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          timerProvider.getFormattedTime(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              );
        },
      ),
    );
  }
}
