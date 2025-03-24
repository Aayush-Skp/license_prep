import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';
import 'package:license_entrance/common/navigation/navigation_service.dart';
import 'package:license_entrance/common/widgets/skp_appbar.dart';

class PageWrapper extends StatelessWidget {
  final bool useOwnAppBar;
  final Widget body;
  final bool useOwnScaffold;
  final bool showAppBar;
  final PreferredSizeWidget? appBar;
  final String? title;
  final Widget? leadingAppIcon;
  final List<Widget> appActions;
  final EdgeInsets? padding;
  final double appBarLeftPadding;
  final double appBarRightPadding;
  final Widget? floatinActionButton;
  final Widget? bottomNavBar;
  final Color? backgroundColor;

  final Function()? onBackPressed;
  final bool showBackButton;

  const PageWrapper({
    Key? key,
    this.useOwnAppBar = false,
    required this.body,
    this.showBackButton = true,
    this.useOwnScaffold = false,
    this.showAppBar = true,
    this.appBar,
    this.appActions = const [],
    this.leadingAppIcon,
    required this.title,
    this.padding,
    this.bottomNavBar,
    this.appBarLeftPadding = CustomTheme.symmetricHozPadding,
    this.appBarRightPadding = CustomTheme.symmetricHozPadding,
    this.floatinActionButton,
    this.backgroundColor,
    this.onBackPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (useOwnScaffold) {
      return body;
    } else {
      return Scaffold(
        floatingActionButton:
            (floatinActionButton != null
                ? AnimatedSwitcher(
                  duration: const Duration(milliseconds: 50),
                  child:
                      MediaQuery.of(context).viewInsets.bottom > 0
                          ? Container()
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: CustomTheme.symmetricHozPadding,
                                  right: CustomTheme.symmetricHozPadding,
                                  bottom: 20,
                                ),
                                child: floatinActionButton,
                              ),
                            ],
                          ),
                )
                : null),
        backgroundColor:
            backgroundColor ??
            Theme.of(NavigationService.context).scaffoldBackgroundColor,
        bottomNavigationBar: bottomNavBar,
        appBar:
            showAppBar
                ? (useOwnAppBar
                    ? appBar
                    : myAppbar(showBackBUtton: showBackButton, title: title))
                : null,
        body: Container(
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding,
              ),
          child: body,
        ),
      );
    }
  }
}
