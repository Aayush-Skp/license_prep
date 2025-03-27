import 'package:flutter/material.dart';
import 'package:license_entrance/app/data_provider.dart';
import 'package:license_entrance/app/theme.dart';
import 'package:license_entrance/common/shared_pref/shared_pref.dart';
import 'package:license_entrance/common/widgets/common_loading_widget.dart';
import 'package:license_entrance/common/widgets/common_pages/offline_page.dart';
import 'package:license_entrance/common/widgets/global_snackbar.dart';
import 'package:license_entrance/pages/questions_block/questions_block_widget.dart';
import 'package:provider/provider.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  bool _isSubmitted = false;
  final Map<int, String?> _selectedAnswers = {};
  final ScrollController _scrollController = ScrollController();

  void _updateSelectedAnswer(int index, String? answer) {
    setState(() {
      _selectedAnswers[index] = answer;
    });
  }

  void _resetState() {
    setState(() {
      _isSubmitted = false;
      _selectedAnswers.clear();
    });
  }

  void _submit() async {
    if (_selectedAnswers.length !=
        Provider.of<DataProvider>(
          context,
          listen: false,
        ).responseModel?.data.length) {
      GlobalSnackbar.show(
        "Please attempt all questions first",
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );
      return;
    }
    setState(() {
      _isSubmitted = true;
    });
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );

    final provider = Provider.of<DataProvider>(context, listen: false);
    int correctAnswers = 0;
    int totalQuestions = provider.responseModel?.data.length ?? 0;

    for (int i = 0; i < totalQuestions; i++) {
      final question = provider.responseModel?.data[i];
      if (question != null && _selectedAnswers[i] == question.correctAnswer) {
        correctAnswers++;
      }
    }
    GlobalSnackbar.showCustomDialog(
      title: 'Results',
      content:
          'You got $correctAnswers out of $totalQuestions questions correct!\n'
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
      child: Consumer<DataProvider>(
        builder: (context, provider, child) {
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
                    isSubmitted: _isSubmitted,
                    selectedAnswer: _selectedAnswers[index],
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
                    provider.fetchData(context: context);
                  }
                },
              )
              : SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    ...questionWidgets,
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () async {
                        if (_isSubmitted) {
                          final currentContext = context;
                          final pageNumber = await SharedPref.getPageNumber();
                          await SharedPref.setPageNumber(pageNumber + 1);
                          _resetState();
                          if (currentContext.mounted) {
                            provider.fetchData(context: context);
                          }
                        } else {
                          _submit();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomTheme.secondaryColor,
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        _isSubmitted ? "Next Page" : 'Submit',
                        style: TextStyle(color: CustomTheme.primaryText),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              );
        },
      ),
    );
  }
}
