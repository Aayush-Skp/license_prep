import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';
import 'package:license_entrance/common/navigation/navigation_service.dart';
import 'package:license_entrance/common/widgets/app_buttons.dart';
import 'package:license_entrance/pages/homescreen/home_screen_widget.dart';

class InitialWidget extends StatefulWidget {
  const InitialWidget({super.key});

  @override
  State<InitialWidget> createState() => _InitialWidgetState();
}

class _InitialWidgetState extends State<InitialWidget>
    with TickerProviderStateMixin {
  bool showTimerOptions = false;
  String selectedMode = "";

  late final AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: AppButtons(
                  minHeight: 65,
                  minWidth: 200,
                  title: 'START THE EXAM',
                  borderRadius: BorderRadius.circular(7),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CustomTheme.primaryText,
                    letterSpacing: 1.2,
                  ),
                  onClicked:
                      () => NavigationService.push(page: HomeScreenWidget()),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.file_copy, size: 20, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          'Total Pages: 30',
                          style: TextStyle(
                            color: CustomTheme.primaryText,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.bookmark, size: 20, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          'Current Page: 7',
                          style: TextStyle(
                            color: CustomTheme.primaryText,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showTimerOptions = !showTimerOptions;
                          if (showTimerOptions) {
                            _animationController.forward();
                          } else {
                            _animationController.reverse();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomTheme.appBarColor,
                        foregroundColor: CustomTheme.primaryText,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        showTimerOptions ? 'Select Mode' : 'Enable Timer',
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: showTimerOptions ? 60 : 0,
                      margin: EdgeInsets.only(top: showTimerOptions ? 8 : 0),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: SizeTransition(
                          sizeFactor: _animationController,
                          axisAlignment: -1,
                          child: Center(
                            child: Wrap(
                              spacing: 10,
                              children:
                                  ['Easy', 'Medium', 'Hard'].map((mode) {
                                    return ChoiceChip(
                                      label: Text(mode),
                                      selected: selectedMode == mode,
                                      onSelected: (selected) {
                                        setState(() {
                                          selectedMode = selected ? mode : "";
                                        });
                                      },
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(CustomTheme.mainLogo, height: 35, width: 35),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '"Don\'t stress, do your best, and forget the rest!"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomTheme.primaryText.withAlpha(180),
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
