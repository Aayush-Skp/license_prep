import 'package:flutter/material.dart';
import 'package:license_entrance/app/data_provider.dart';
import 'package:license_entrance/common/shared_pref/shared_pref.dart';
import 'package:license_entrance/common/widgets/app_buttons.dart';
import 'package:license_entrance/common/widgets/common_loading_widget.dart';
import 'package:license_entrance/common/widgets/common_pages/offline_page.dart';
import 'package:license_entrance/common/widgets/global_snackbar.dart';
import 'package:license_entrance/common/widgets/page_wrapper.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _startTimer());
  }

  void _startTimer({int? time}) async {
    time ??= await SharedPref.getTime();
    if (!mounted) return;
    final provider = context.homeScreenProvider;
    if (provider.remainingSeconds == time &&
        !provider.isTimerRunning &&
        !provider.isSubmitted) {
      provider.startTimer(
        onTimerComplete: () {
          provider.submit(isSkillable: true, onScrollToTop: _scrollToTop);
        },
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 1200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: "Comp Engineering",
      showAppBar: true,
      body: Consumer2<DataProvider, HomeScreenProvider>(
        builder: (context, dataProvider, homeScreenProvider, child) {
          List<Widget> questionWidgets = [];
          if (dataProvider.responseModel?.data != null) {
            questionWidgets =
                dataProvider.responseModel!.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  final datum = entry.value;
                  RegExp regExp = RegExp(r'Q\d+:\s*(.*)');
                  Match? match = regExp.firstMatch(datum.question);
                  final question = match?.group(1) ?? '';
                  return QuestionBlockWidget(
                    options: datum.options,
                    question: question,
                    correctAnswer: datum.correctAnswer,
                    isSubmitted: homeScreenProvider.isSubmitted,
                    selectedAnswer: homeScreenProvider.selectedAnswers[index],
                    onAnswerSelected:
                        (value) => homeScreenProvider.updateSelectedAnswer(
                          index,
                          value,
                        ),
                  );
                }).toList();
          }
          return dataProvider.isLoading
              ? CommonLoadingWidget()
              : dataProvider.isOffline
              ? OfflinePage(
                message: dataProvider.errorMessage.toString(),
                onRefresh: () async {
                  homeScreenProvider.resetTimer();
                  _startTimer();
                  final currentContext = context;
                  if (currentContext.mounted) {
                    dataProvider.fetchData();
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
                                    "You are currently on page no: ${dataProvider.currentPageNo}",
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                  );
                                },
                                title: dataProvider.currentPageNo.toString(),
                              ),
                            ),
                            SizedBox(width: 7),
                            Expanded(
                              flex: 4,
                              child: AppButtons(
                                title:
                                    homeScreenProvider.isSubmitted
                                        ? "Next Page"
                                        : 'Submit',
                                onClicked: () async {
                                  if (homeScreenProvider.isSubmitted) {
                                    final currentContext = context;
                                    await SharedPref.setPageNumber(
                                      dataProvider.currentPageNo + 1,
                                    );
                                    homeScreenProvider.resetState();
                                    homeScreenProvider.resetTimer();
                                    homeScreenProvider.startTimer(
                                      onTimerComplete: () {
                                        homeScreenProvider.submit(
                                          isSkillable: true,
                                          onScrollToTop: _scrollToTop,
                                        );
                                      },
                                    );
                                    if (currentContext.mounted) {
                                      dataProvider.fetchData();
                                    }
                                  } else {
                                    homeScreenProvider.submit(
                                      onScrollToTop: _scrollToTop,
                                    );
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
                          homeScreenProvider.getFormattedTime(),
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
